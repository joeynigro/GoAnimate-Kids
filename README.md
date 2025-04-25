# GoAnimate Kids
GoAnimate Kids is the children's version of Wrapper: Offline.

[Find more info in the wiki.](https://github.com/Wrapper-Offline/Wrapper-Offline/wiki)

## Running / Installation
To start GoAnimate Kids on Windows, Download and run the installer [here]((https://goanimatekids.weebly.com/)) It'll automate just about everything for you and, well, start GoAnimate Kids.

If you want to import videos and characters from the original GoAnimate or any other clones of it, open its folder and drag the "_SAVED" folder into GoAnimate's "wrapper" folder. If you have already made any videos or characters, this will not work. Please only import on a new install with no saved characters or videos, or take the "_SAVED" folder in GoAnimate out before dragging the old one in. If you want to import character IDs from the original LVM, you can paste `&original_asset_id=[ID HERE]` at the end of the link for the matching character creator.

## Dependencies
This program relies on Flash, Node.js and http-server to work properly. SilentCMD is also used to suppress all the extra logging noise you'd only need for troubleshooting and development. These all have been included with the project (utilities folder) to ensure full offline operation and will be installed if missing. The "wrapper" folder and http-server have their own dependencies, but they are included as well.

## License
Most of this project is free/libre software[1] under the MIT license. You have the freedom to run, change, and share this as much as you want.
This includes:
  - Files in the "wrapper" folder
  - Batch files made for GoAnimate Kids
  - Node.js
  - http-server
  - SilentCMD
  - Chromium Web Store

ungoogled-chromium is under the BSD 3-Clause license, which grants similar rights, but has some differences from MIT. MediaInfo has a similar BSD 2-Clause license. 7zip's license is mostly LGPL, but some parts are under the BSD 3-clause License, and some parts have an unRAR restriction. Stylus is under the GNU GPLv3 license. These licenses can be found in each program's folder in utilities\sourcecode.

The source code for compiled programs are all stored in utilities\sourcecode, and you can modify these as you wish. Parts of Offline that run from their source code directly (such as batch scripts) are not included in that folder, for obvious reasons.

Flash Player (utilities folder) and GoAnimate's original assets (server folder) are proprietary and do not grant you these rights, but if they did, this project wouldn't need to exist. Requestly, an addon included in Offline's browser, is sadly proprietary software, but you're free to remove the Chromium profile and use a fresh one if this bothers you. Requestly is primarily included because of how popular it is with our community.

## Footnotes
[1] - See <https://www.gnu.org/philosophy/free-sw.html> for a better definition of free software.
