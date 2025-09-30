package main

import "core:os"

main :: proc() {
    // Build raylib first
    build_raylib()
    
    // Build our Odin program
    build_odin()
}

build_raylib :: proc() {
    fmt.println("Building raylib...")
    
    // Change to raylib source directory
    old_dir := os.get_current_directory()
    defer os.change_directory(old_dir)
    
    os.change_directory("deps/raylib/src")
    
    // Build raylib
    result := os.execute_command("make PLATFORM=PLATFORM_DESKTOP")
    if result.exit_code != 0 {
        fmt.eprintln("Failed to build raylib:", result.output)
        os.exit(1)
    }
    
    // Ensure build directory exists
    os.make_directory("../../build")
    
    // Copy library to build directory
    os.copy_file("libraylib.a", "../../build/libraylib.a", false)
    
    fmt.println("Raylib built successfully!")
}

build_odin :: proc() {
    fmt.println("Building Odin program...")
    
    // Build command with raylib linking
    cmd := `odin build src/main.odin -file -out:build/game -extra-linker-flags:"-L./build -lraylib -lm -lpthread -ldl -lX11 -lGL"`
    
    result := os.execute_command(cmd)
    if result.exit_code != 0 {
        fmt.eprintln("Failed to build Odin program:", result.output)
        os.exit(1)
    }
    
    fmt.println("Odin program built successfully!")
    fmt.println("Run: ./build/game")
}