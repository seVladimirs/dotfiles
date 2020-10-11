# introduction

I was a little tired of spending time to peronilize [SAP Business Application Studio](https://help.sap.com/viewer/9d1db9835307451daa8c930fbd9ab264/Cloud/en-US/8f46c6e6f86641cc900871c903761fd4.html) each time I got a new instance of it. That led to this project.

## install

Symlink the appropriate files in `.dotfiles` to your home directory, by running this:

```sh
git clone https://github.com/seVladimirs/dotfiles
cd dotfiles
chmod +x init.sh
./init.sh
```

Once done, reload your browser and terminal.

![example screenshot](https://i.imgur.com/szCLyPO.png)

## SAP Business Application Studio settings

Don't forget to download and install SAP Business Application Studio's fonts which are defined in settings.json:

- Font Family for Code Editor [Fira Code](https://github.com/tonsky/FiraCode)

## Appendix

- Once SAP Business Application Studio is stopped symlinks are gone, therefore we are copying files instead of symlinking them as normally done in dotfiles.
