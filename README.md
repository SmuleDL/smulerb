# smulerb
A simple Smule Sing! command line media downloader.

## How to use
0. Assuming you have Ruby SDK installed.
1. Clone or download this repo.
2. Extract the files to wherever you want, and change current directory to the directory where `smule.rb` was extracted.
3. Run `bundle`.
4. Make the `smule.rb` file executable by using `chmod a+x`.
5. Download a song or video from Smule by using the following command on Terminal.
```
./smule.rb <link to smule collab>
```
e.g.
```
./smule.rb https://www.smule.com/recording/shimo-kumikyoku-nico-nico-douga/519002350_1591579869
```
5. The file will be downloaded at the same location where `smule.rb` is placed.

## Checklists

- [x] Accept link arguments from terminal.
- [ ] Add exceptions.
- [ ] Add progress bar during file download.
- [ ] Add ability to change default download location.
