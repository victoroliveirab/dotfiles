Remember to give execution permission to shell scripts:

```bash
chmod +x bootstrap.sh
chmod +x pass.sh
chmod +x pass-export.sh
chmod +x lightdm/script.sh
```

If cloning to a new machine, update the level of trust to the maximum:

```bash
gpg --edit-key EMAIL
gpg> trust
5
y
```
