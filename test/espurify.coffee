import espurify from 'espurify'

import dd from 'ddeyes'

import {
  getAST
  ricffAST
  ASTToCode
} from '../src/util'

jsCode = 'import calc from "../src";'

jsCode = 'import calc from "hello/world";'

# jsCode = """
#   async function a() {
#     await request('url');
#   };
# """

originalAst = ricffAST getAST jsCode

# dd originalAst

purifiedClone = espurify originalAst

dd purifiedClone
dd ASTToCode originalAst
