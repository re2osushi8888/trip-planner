# Error Handling

| Situation              | Action                                                                                |
| ---------------------- | ------------------------------------------------------------------------------------- |
| Issue not found        | Stop and ask the user to verify the issue number                                      |
| Working tree is dirty  | Warn the user and ask them to stash or commit changes before proceeding               |
| Branch already exists  | Inform the user and ask whether to use the existing branch or choose a different name |
| `gh` not authenticated | Prompt the user to run `gh auth login`                                                |
