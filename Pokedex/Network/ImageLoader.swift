//
//  ImageLoader.swift
//  Pokedex
//
//  Created by Abdo on 24.06.21.
//

import Foundation
import UIKit

final class ImageLoader {
	private let cachedImages = NSCache<NSURL, UIImage>()

	private final func image(url: NSURL) -> UIImage? {
		return cachedImages.object(forKey: url)
	}

	public func load(url: URL, complete: @escaping (Result<UIImage, Never>) -> Void) {
		if let cachedImage = image(url: url as NSURL) {
			DispatchQueue.main.async {
				complete(.success(cachedImage))
			}
			return
		}

		DispatchQueue.global().async { [weak self] in
			if let data = try? Data(contentsOf: url) {
				if let image = UIImage(data: data) {
					complete(.success(image))
					self?.cachedImages.setObject(image, forKey: url as NSURL, cost: data.count)
				}
			}
		}
	}

	@available(iOS 15.0, *)
	public func load(url: URL) async -> UIImage? {
		if let cachedImage = image(url: url as NSURL) {
			return cachedImage
		}

		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			guard let image = UIImage(data: data) else {
				return nil
			}

			cachedImages.setObject(image, forKey: url as NSURL, cost: data.count)

			return image
//			let data = async {
//				try? Data(contentsOf: url)
//			}
//			let image = await data.get() ?? Data()
//
//			return UIImage(data: image)
		} catch {
			print(error.localizedDescription)
		}
		return nil
//		await withCheckedContinuation { cont in
//			load(url: url) { image in
//				cont.resume(with: image)
//			}
//		}
	}
}
