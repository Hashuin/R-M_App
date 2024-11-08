const String fetchCharacters = """
query Query(\$page: Int, \$name: String) {
  characters(page: \$page, filter: { name: \$name }) {
    info {
      count
    }
    results {
      id
      name
      image
      status
      species
      type
      gender
      origin {
        name
        type
        dimension
      }
      location {
        name
        type
        dimension
      }
    }
  }
}
""";