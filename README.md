# smelli

A small iOS app with an interactive **Swift & SwiftUI** tutorial built in.

## Run

1. Open `smelli.xcodeproj` in Xcode.
2. Select an iPhone Simulator or device.
3. Press ⌘R.

The app launches into the tutorial catalog (`TutorialHomeView`).

## Tutorial

| Location | Purpose |
|----------|---------|
| [smelli/Tutorial/README.md](smelli/Tutorial/README.md) | Full guide: structure, adding lessons, playgrounds, progress |
| In-app **About** (book icon on home) | How to use the tutorial as a learner |
| `TutorialModels.swift` | Doc comments on types and how to extend them |

### Modules

- Swift Basics — variables, types, optionals, control flow
- SwiftUI Views — views, layout, modifiers
- State & Binding — `@State`, `@Binding`
- Lists & Navigation — `List`, `NavigationStack`
- iOS App Structure — `@main`, scenes, previews

`ContentView.swift` is kept as a separate playground and is not the app entry point by default.
