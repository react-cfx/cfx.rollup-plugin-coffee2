import path from 'path'
import fs from 'fs'

# import dd from 'ddeyes'
# import espurify from 'espurify'

import * as acorn from 'acorn'
import estraverse from 'estraverse'
import escodegen from 'escodegen'

# real coffee file Path
rCFPath = (filePath) =>
  fileObj = {
    exists: fs.existsSync filePath
    (path.parse filePath)...
  }
  unless fileObj.exists # file isnt exists
    return filePath if fileObj.ext is '.js'
    if fileObj.ext is '.coffee'
      return rCFPath path.format
        root: '/ignored'
        dir: fileObj.dir
        base: fileObj.base
        name: 'ignored'
        ext: '.js'
    else return rCFPath "#{filePath}.coffee"
  else # file exists
    unless fileObj.ext is '' # isnt dir
    then return filePath
    else return rCFPath path.join filePath, 'index.coffee'

# replace import coffee file from AST
ricffAST = (ast, dirname = __dirname) =>
  estraverse.replace ast
  ,
    leave: (currentNode, parentNode) ->
      if currentNode.type is 'ImportDeclaration'
        fileParseObj = path.parse currentNode.source.value
        return currentNode if (
          fileParseObj.root is '' and
          fileParseObj.dir is ''
        )
        filePath = rCFPath path.join dirname
        , currentNode.source.value
        # dd filePath
        currentNode.source.value = filePath
        # dd espurify currentNode
      currentNode

getAST = (source) =>
  comments = []
  tokens = []

  acorn.parse source
  ,
    sourceType: 'module'
    # collect ranges for each node
    ranges: true
    # collect comments in Esprima's format
    onComment: comments
    # collect token ranges
    Token: tokens

ASTToCode = (ast) -> escodegen.generate ast

export {
  rCFPath
  ricffAST
  getAST
  ASTToCode
}