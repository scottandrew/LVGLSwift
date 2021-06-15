// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import Foundation

let package = Package(
    name: "LVGLSwift",
    products: [
        .executable(name: "LVGLDemo", targets: ["LVGLDemo"]),
        .library(name: "LVGLSwift", targets: ["LVGLSwift"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "LVGLSwift",
            dependencies: [],
            exclude: ["lvgl/Kconfig",
                      "lvgl/scripts",
                      "lvgl/tests",
                      "lvgl/examples",
                      "lvgl/docs",
                      "lv_drivers/docs",
                      "lvgl/CMakeLists.txt",
                      "lvgl/src/misc/lv_misc.mk",
                      "lvgl/librarly.json",
                      "lvgl/lvgl.mk",
                      "lvgl/component.mk",
                      "lvgl/README.md",
                      "lvgl/src/extra/extra.mk",
                      "lvgl/src/gpu/lv_gpu.mk",
                      "lvgl/src/hal/lv_hal.mk",
                      "main.txt",
                      "lvgl/src/draw/lv_draw.mk",
                      "lvgl/src/font/lv_font.mk",
                      "lvgl/library.json",
                      "lvgl/library.properties",
                      "lvgl/LICENCE.txt",
                      "lvgl/src/core/lv_core.mk",
                      "lvgl/src/font/korean.ttf",
                      "lvgl/src/widgets/lv_widgets.mk",
                      "lvgl/zephyr/module.yml",
                      "lv_drivers/LICENSE",
                      "lv_drivers/README.md",
                      "lv_drivers/gtkdrv/broadway.png",
                      "lv_drivers/wayland/README.md",
                      "lv_drivers/gtkdrv/README.md",
                      "lv_drivers/lv_drivers.mk",
                      "lv_drivers/CMakeLists.txt",
                      "lv_drivers/library.json"
            ],
            cSettings: [
                        .headerSearchPath("lv_drivers"),
                        .headerSearchPath("lvgl"),
                        .unsafeFlags(["-I/usr/local/Cellar/sdl2/2.0.14_1/include/SDL2", "-I/opt/homebrew/include/SDL2", "-D THREAD_SAFE", "-D LV_LVGL_H_INCLUDE_SIMPLE"])
                        ],
        linkerSettings: [.unsafeFlags(["-L/opt/homebrew/lib","-lSDL2"])]
            
        ),
        .target(name: "LVGLDemo",
                dependencies: ["LVGLSwift"])
//        .testTarget(
//            name: "LVGLSwiftTests",
//            dependencies: ["LVGLSwift"],
//            exclude: ["*.py",
//                      "*.yml",
//                      "*.mk",
//                      "*.ttf",
//                      "*.txt",
//                      "lvgl/Kconfig",
//                      "lvgl/scripts",
//                      "lvgl/tests",
//                      "lvgl/examples",
//                      "lvgl/docs"]),
    ]
)
