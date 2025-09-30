package main

import rl "vendor:raylib"

main :: proc() {
    screen_width :: 1920
    screen_height :: 1080

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
