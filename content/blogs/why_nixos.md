+++
title = "What! Why Do You Use NixOS?"
date = 2026-03-27
draft = true

[taxonomies]
categories = [ "linux"]
tags = ["linux", "nixos"]

[extra]
lang = "en"
toc = true
comment = false
copy = false
math = false
mermaid = false
featured = false
reaction = false
+++

## Previous Story

So, I started on Linux back in June 2024 — Started on Ubuntu like basically everyone else — it held my hand, it was fine, whatever.
Then my machine started crying under the weight of it, honestly, Gnome is heavy, and my pc specs were too low for Ubuntu and Gnome.
so I thought, okay, Kali. Yeah I know, I know — I didn't really know that Kali Linux is for hacking and that kind of stuff. Kali is
not really meant to be a daily driver, but honestly? It ran lighter, and at the time I just needed something that worked without 
eating all my RAM. I used Xfce on Kali. It was way lighter for my pc. I used Kali for years until I bought another computer.

But When I bought a new computer. I'd to install Kali Linux on it again. Cause you know... I tried installing Arch 4 times, 
every time something was missing or broken. (**Skill issue**). So, I started using Kali Linux again. But I don't like GNOME (not that i hate it).
I wanted Hyprland. Then I found out there's `archinstall`, and Hyprland supports Arch better than most distros. So I gave it
one more shot — and it worked. Arch + Hyprland. I was happy. Honestly though? Arch doesn't automatically make you read the wiki or learn the system.
No distro does. That's on you. It depends on what you do with it and how you use it. But here's the thing with Arch — it's still mutable. You're pacman -Syu-ing your way through life.
Arch IS GREAT. I cannot disagree.

> Can we just move on to Nix?

## NixOS

While learning programming, I tried a bunch of different languages. Last year I started learning C++, and that pulled me toward
systems programming. I like systems I can reason about.

I installed NixOS out of curiosity — how does a distro manage to configure an entire system in a single declarative configuration?
Can I actually use that? I wasn't even looking to switch from Arch. But the idea felt too interesting to ignore. I was following a 
video where the guy was setting up Flakes and Home Manager simultaneously, which... is a lot for a first install. But I got through it.

Anyways, The configuration, It's almost like a pure function: same config in, same system out. Every time. No hidden state, no "works on my machine" nonsense. 
That's just... beautiful.

And then there's the reproducibility. nix develop gives me isolated, reproducible dev environments without polluting my system. It's like mathematical scoping — variables don't leak.
From a FOSS and privacy perspective, NixOS ticks all the boxes too. Fully open, massive community, and you have complete, auditable control over what's on your machine. No black boxes.
Also — and this is huge — rollbacks. Every generation of your system is kept. Broke something? One command and you're back. It's like Git, but for your entire OS. This is too noob saying.
Though I'm still noob on NixOS. There's so many stuff I need to know. This is too small saying about NixOS. I want to write more about NixOS.


Is it a steep learning curve? Absolutely. The Nix language took me a while to wrap my head around — it's a lazy, purely functional language, which is its own kind of rabbit hole.

> Whatever, I'm not going back.


### *My first basic configuration:*

``` nix
{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  users.users.rafid = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.bash;
  };

  environment.systemPackages = with pkgs; [
    git curl wget
    vim neovim
  ];

  system.stateVersion = "25.11";
}
```


*A funny true meme from other site:*
![img](https://zackerthescar.com/img/nixos.svg)
