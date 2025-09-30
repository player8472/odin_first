package main

import "core:fmt"
import rl "vendor:raylib"

main :: proc() {
    screen_width :: 800
    screen_height :: 450

    rl.InitWindow(screen_width, screen_height, "Odin + Raylib")
    defer rl.CloseWindow()

    rl.SetTargetFPS(60)

    for !rl.WindowShouldClose() {
        rl.BeginDrawing()
        defer rl.EndDrawing()

        rl.ClearBackground(rl.RAYWHITE)
        rl.DrawText("Hello, Raylib from Odin!", 190, 200, 20, rl.DARKGRAY)
    }
}
