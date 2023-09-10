# dots
> configurations for wizards

this is my nix configuration for dotfiles across my various systems.

---

## Getting Started 


* [install nix for your os](https://nix.dev/tutorials/install-nix)

i would recommend not going for the multi user setup as this will cause problems on heavily audited machines. (i.e. work machines managed by IT departments). but hey, if that doesnt apply to you go for it.

more info on this particular topic can be found [here](https://nixos.org/manual/nix/stable/installation/installing-binary#installing-a-binary-distribution)

```bash
# whatever nix thinks is best for your system (currently single for linux, multi for mac)
curl -L https://nixos.org/nix/install | sh

# explicit multi user
curl -L https://nixos.org/nix/install | sh -s -- --daemon

# explicit single user
curl -L https://nixos.org/nix/install | sh -s -- --no-daemon
```

* enable [nix-command](https://nixos.wiki/wiki/Nix_command) and [flakes](https://nixos.wiki/wiki/Flakes)


```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```
---


## Running


`nix build <YOUR PATH>.#homeConfigurations.<YOUR USER>.activationPackage`

`?dir=<SOME PATH>`

---

## for the curious:
if you're just learning nix expressions, check out the playground using `evaluate``.

`./scripts/evaluate playground`

modify playground files to learn parts of the expression language.

---

## useful commands with this repo


`nix-env -q` - list everything installed via nix-env. (this is the old way)

`nix profile list` - list everything installed via nix profile. (command style using profiles)

`nix-shell -p home-manager` - run a shell with `home-manager`

`nix store gc` - garbage collect the system.


