import path from 'path'
import fs from 'fs'

# import dd from 'ddeyes'
# import espurify from 'espurify'

import * as acorn from 'acorn'
import estraverse from 'estraverse'
import escodegen from 'escodegen'

# real coffee file Path
rCFPath = (filePath) =>

  getFileObj = (file) -> {
    exists: fs.existsSync file
    (path.parse file)...
  }

  fileObj = getFileObj filePath

  unless fileObj.exists # file isnt exists

    fileObj = 
      coffee: do ->
        _path = path.format {
          root: path.join fileObj.root, fileObj.dir + '/'
          name: fileObj.base
          ext: '.coffee'
        }
        path: _path
        obj: getFileObj _path
      js: do ->
        _path = path.format {
          root: path.join fileObj.root, fileObj.dir + '/'
          name: fileObj.base
          ext: '.js'
        }
        path: _path
        obj: getFileObj _path

    if fileObj.coffee.obj.exists
      return rCFPath fileObj.coffee.path
    if fileObj.js.obj.exists
      return rCFPath fileObj.js.path
    return null

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
        currentNode.source.value = filePath if filePath?
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