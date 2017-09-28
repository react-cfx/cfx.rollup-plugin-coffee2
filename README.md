# cfx.rollup-plugin-coffee2

受 [rollup-plugin-coffee2](https://github.com/zeekay/rollup-plugin-coffee2) 启发

有两处修改：

1. 只支持 coffee 2，不再支持 coffee 1
1. 支持直接 import xxx from "./#{pkgname}" 的写法，
   默认查找 "./#{pkgname}.coffee" / "./#{pkgname}/index.coffee"，
   找不到会替换为 '.js'
