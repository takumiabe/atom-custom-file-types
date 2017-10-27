module.exports =
class CustomFileTypesView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('custom-file-types')

    @createTable()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getTitle: ->
    "Custom File Types"

  getElement: ->
    @element

  createTable: ->
    allFileTypes = new Set()
    fileTypeToGrammar = {}
    for grammar in atom.grammars.getGrammars()
      for ft in grammar.fileTypes
        allFileTypes.add ft
        fileTypeToGrammar[ft] ||= []
        fileTypeToGrammar[ft].push grammar

    customFileTypes = atom.config.get('core.customFileTypes')
    customFileTypeToGrammer = {}
    for scopeName of customFileTypes
      grammar = atom.grammars.grammarForScopeName(scopeName)

      for ft in customFileTypes[scopeName]
        allFileTypes.add ft
        customFileTypeToGrammer[ft] ||= []
        customFileTypeToGrammer[ft].push grammar

    if false
      for scopeName of customFileTypes
        console.debug(scopeName)
        console.debug(customFileTypes[scopeName])

      for grammar in atom.grammars.getGrammars()
        console.debug(grammar.scopeName)
        console.debug(grammar.fileTypes)
      console.debug fileTypeToGrammar
    console.debug customFileTypeToGrammer

    table = document.createElement('table')
    tr = document.createElement('tr')
    td = document.createElement('th')
    td.textContent = 'Pattern of Path'
    tr.appendChild(td)

    td = document.createElement('th')
    td.textContent = 'Language'
    tr.appendChild(td)

    td = document.createElement('th')
    td.textContent = 'Package'
    tr.appendChild(td)

    td = document.createElement('th')
    td.textContent = 'overrides by'
    tr.appendChild(td)

    table.appendChild(tr)

    for ft in Array.from(allFileTypes).sort()
      tr = document.createElement('tr')

      td = document.createElement('td')
      td.textContent = ft
      tr.appendChild(td)

      grammar = fileTypeToGrammar[ft][0]

      td = document.createElement('td')
      td.textContent = grammar.name
      tr.appendChild(td)

      td = document.createElement('td')
      td.textContent = grammar.packageName
      tr.appendChild(td)

      td = document.createElement('td')
      override_grammar = customFileTypeToGrammer[ft]
      td.textContent = override_grammar[0].name if override_grammar
      tr.appendChild(td)

      table.appendChild(tr)
    @element.appendChild(table)
