import path from 'path'
import { createFilter } from 'rollup-pluginutils'

# import dd from 'ddeyes'
# import espurify from 'espurify'

import {
  getAST
  ricffAST
  ASTToCode
} from './util'

sourceMap = (out) ->

  if out.v3SourceMap
  then JSON.parse out.v3SourceMap
  else null

export default (opts = {}) ->

  filter = createFilter(
    opts.include
    opts.exclude
  )

  name: 'coffeepath'
  transform: (code, id) ->

    return {
      code
    } unless filter id 

    return {
      code
    } unless (path.extname id) is '.coffee'

    # dd path.dirname id

    code: ASTToCode ricffAST(
      getAST code
      path.dirname id
    )
    map: sourceMap code
