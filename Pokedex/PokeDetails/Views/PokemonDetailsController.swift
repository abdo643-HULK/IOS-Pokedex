

import UIKit

private let cornerRadius: CGFloat = 10

class PokemonDetailsController: UIViewController { // , UITableViewDataSource, UITableViewDelegate
//	private var presenter = PokemonDetailsPresenter()
	private let presenter = PokemonDetailsPresenter()
	private let pokemonbox = PokemonBoxView()
	private let statsView = StatsView()

	private let scrollView: UIScrollView = {
		let s = UIScrollView()
		s.translatesAutoresizingMaskIntoConstraints = false
		return s
	}()

	private let stackView: UIStackView = {
		let s = UIStackView()
		s.translatesAutoresizingMaskIntoConstraints = false
		s.isLayoutMarginsRelativeArrangement = true
		s.axis = .vertical
		s.alignment = .center
		s.distribution = .fill
		s.layoutMargins = UIEdgeInsets(top: 17, left: 15, bottom: 40, right: 15)
		return s
	}()

	private var pokemon: PokemonDetails?

	public var id: UInt16 = 0
	public var name: String = ""
	public var imageURL: URL!

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationController?.navigationBar.prefersLargeTitles = false
		pokemonbox.name = name
		pokemonbox.imageURL = imageURL

		displayActivityIndicatorView()

		async {
			await presenter.getPokemonDetails(id: Int(id))
			guard var pokemon = presenter.pokemon else {
				return
			}
			self.pokemon = pokemon
			pokemonbox.types = pokemon.types

			statsView.color = PokeType(rawValue: pokemon.types.first ?? "")?.color ?? PokeType.Unkown.color
			statsView.basetats = pokemon.baseStats
			statsView.minStats = pokemon.minStats
			statsView.maxStats = pokemon.maxStats

			hideActivityIndicatorView()
		}

		setupViews()
		setupConstraints()
	}

	private func setupViews() {
		view.addSubview(scrollView)
		scrollView.addSubview(stackView)

		stackView.addArrangedSubview(pokemonbox)
		stackView.addArrangedSubview(statsView)

		stackView.setCustomSpacing(20, after: pokemonbox)

		pokemonbox.setupView()
		statsView.setupView()
	}

	private func setupConstraints() {
		let constant: CGFloat = 20

		let frameLayoutGuide = scrollView.frameLayoutGuide
		let safeMargins = view.safeAreaLayoutGuide
		let contentLayoutGuide = scrollView.contentLayoutGuide
		let stackLayout = stackView.safeAreaLayoutGuide

		NSLayoutConstraint.activate([
			frameLayoutGuide.leadingAnchor.constraint(equalTo: safeMargins.leadingAnchor),
			frameLayoutGuide.trailingAnchor.constraint(equalTo: safeMargins.trailingAnchor),
			frameLayoutGuide.topAnchor.constraint(equalTo: safeMargins.topAnchor),
			frameLayoutGuide.bottomAnchor.constraint(equalTo: safeMargins.bottomAnchor),

			stackView.widthAnchor.constraint(equalTo: safeMargins.widthAnchor),
			stackView.leadingAnchor.constraint(equalTo: contentLayoutGuide.leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: contentLayoutGuide.trailingAnchor),
			stackView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
			stackView.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor, constant: -constant),

			pokemonbox.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
			pokemonbox.heightAnchor.constraint(equalToConstant: 400),

			statsView.leadingAnchor.constraint(equalTo: stackLayout.leadingAnchor, constant: 20),
			statsView.trailingAnchor.constraint(equalTo: stackLayout.trailingAnchor, constant: -20),
		])
	}

//	private func setupConstraintsForView() {
//		let constant: CGFloat = 20
//
//		let safeMargins = view.safeAreaLayoutGuide
//		let frameLayoutGuide = scrollView.frameLayoutGuide
//		let contentLayoutGuide = scrollView.contentLayoutGuide
//
//		NSLayoutConstraint.activate([
//			frameLayoutGuide.leadingAnchor.constraint(equalTo: safeMargins.leadingAnchor),
//			frameLayoutGuide.trailingAnchor.constraint(equalTo: safeMargins.trailingAnchor),
//			frameLayoutGuide.topAnchor.constraint(equalTo: safeMargins.topAnchor),
//			frameLayoutGuide.bottomAnchor.constraint(equalTo: safeMargins.bottomAnchor),
//
//			pokemonbox.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
////			pokemonbox.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 5),
//			pokemonbox.heightAnchor.constraint(equalToConstant: 400),
//
////			statsView.topAnchor.constraint(equalTo: pokemonbox.bottomAnchor, constant: 20),
//			statsView.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
////			statsView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
//		])
//	}
}
