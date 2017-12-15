# import coffee2 from 'rollup-plugin-coffee2'
import cleanup from 'rollup-plugin-cleanup'

import {
  coffee2
  coffeepath
} from './src'
# } from './dist/bundle'
# } from 'cfx.rollup-plugin-coffee2'

export default
  input: './index.js'
  output:
    file: './dist/bundle.js'
    format: 'cjs'
  plugins: [
    coffee2
      bare: true
      sourceMap: true
    coffeepath()
    cleanup()
  ]
