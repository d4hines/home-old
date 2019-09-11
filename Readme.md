# Home

## Commands
- `up` - Builds everything and launches Finsemble. It waits for Core to finish before running `npm run dev` in the Seed.
- `add {wpf|console}` - Applies the WPF or ShowConsole git patches. WPF is hard coded to my machine - you'll have to modify it.
- `fsbl` - Also aliased as `f`
  - `fsbl sha` - Prints out all the project SHA's, copying them to the clipboard.
  - `fsbl co [a git branch name]` - Checks out the same git branch on every project. E.g `f co planned/3.13.0` checks out planned/3.13.0 on every project.
