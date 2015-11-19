在 swift 中使用 [cocoaui](http://www.cocoaui.com/) 写原生界面的 demo, [cocoaui 的 github 地址在此](https://github.com/ideawu/cocoaui)  

为了写 html + css 时更流畅并且避免看到太多的语法 warning, 自己 [fork 了一个版本](https://github.com/tukdesk/cocoaui) 并做了几处修改  

由于 cocoaui 依赖于 libxml2, 因此本地运行的时候需要 link libxml2.dylib, 方法如下:

    ```
    XCode 中,
    target 
    -> cocoaui-demo-swift
    -> General
    -> Linked Frameworks and Libraries
    -> +
    -> Add Other
    -> Cmd + Shift + G, 进入 libxml2.dylib 所在的目录 (我这里是 /usr/lib )
    -> 完成添加
    ```