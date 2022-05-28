# WBRUTER

##### This tool is NOT for hacking your ex girlfriend, your boss or anything like that, the purpose is to check YOUR security and your passwords security from  various websites/tools/keys. It's up to you how to use wbruter but remember, the developer of this tool can never be held responsible under any circumstances for what other users have chosen to do with the tool. Images presented do not have to be from the developer himself and is shared screenshots from some of my friends in universe and they are and will allways be unknown for you and even myself! wuseman doing this as a non-profit hacker / cracker / breaker depending on what you choose to call it. Upgrade in Progress....Are your password cracked on the picture? Don't blame me, blame the site admin that is NOT banning bruteforce attempts
 + It's not my screens, k? Whatever, that guy who used my tool for this wanted to show me his screens, looks cool, right? (read the tabs if you're smart, I did! You will now know wich sites that does NOT block bruteforce attempts, fuck them, they put us ALL in danger by not knowing how to secure their sites so that's why I sharing this pictures (to be added - a simple oneliner with inotifytools + iptables + regex can solve this issue but the websites dont give a fuck about security anymore)
   
Don't hate the player hate the game!

![PXL_20211205_050640387](https://user-images.githubusercontent.com/26827453/170805172-18164670-ddc6-4037-849a-0c43ccec9651.jpg)
![PXL_20211205_050737625](https://user-images.githubusercontent.com/26827453/170805173-a0ebf440-c01e-4d2e-b3dd-bd293db2bb49.jpg)

## INFO: 2022-05-28: 

Redo the whole project as I have not updated anything for 2 years and it has certainly become popular this repot, now we do things a little faster and a little snow builder they are 2022!  When this text is not visible it is ready then, use "wbruter.working.sh" plz, I do this on the go / dirty. Should be done today or tomorrow, until then, happy cracking/hacking/breaking with the slow method ;-)

How to stay safe? It's simple, stop using your phone device: 📵

#### References ^

[Apple's Operating Systems Are Malware](https://www.gnu.org/proprietary/malware-apple.html)

[Google confirms that advanced backdoor came preinstalled on Android devices](https://www.reddit.com/r/linux/comments/bxp25x/google_confirms_that_advanced_backdoor_came/)

[After Google successfully beat back Triada in 2017, its developers found a new way in.](https://arstechnica.com/information-technology/2019/06/google-confirms-2017-supply-chain-attack-that-sneaked-backdoor-on-android-devices/)

[PDF - Google Android Security 2018 Report Final](https://source.android.com/security/reports/Google_Android_Security_2018_Report_Final.pdf)

All respect to Google who tells the truth so there is not much to reveal, I do not share this project because I hack accounts but because I test the security of my own devices. Why do you think I'm like you? Don't ask me for hacking personal acccounts or phones, that is what idiots and BREAKERS does, not hackers so dont use my tool for get youtube viewers or visitors for earn cash your fool. I doing this without asking for donations, favors. I follow the hacking ethics and want everything to be FREE and OPEN so, so plz (if you're not one of the ppl that selling my tools on darknet ignore this) 
 fuck you and stop spread bullshit! This is nto a hacking tool for crack a stolen devices pincode, it is for keep my friends/family updated how to secure their devices since I dont use any device myself, I don't use malware! k? ( like I have any friends 🏴‍☠️ )
 
 
 
#### README


wbruter is is the first tool wich has been released as open source wich can guarantee **100%** that your pin code will be cracked aslong as usb debugging has been enable. wbruter also includes some other brute methods like dictionary attacks for gmail, ftp, rar, zip and some other file extensions. 

wbruter will allways try to bring support for rare protocols, wbruter wont contain common stuff like other brute tools cover like facebook, snapchat, instagram and you name it (except a few exceptions, very few)

## INFO: 2020-07-11:

Android and Google, now have set a rule for locksettings via cli as via gui earlier, if you try to many attempts within X seconds you will be blocked for X seconds so wbruter via cli wont work anymore on devices that has been upgraded to latest version Android 10, older version should work fine unless they are upgraded to latest android version. 

## Enable USB-Debugging via the methods below:

#### Via GUI: 

Go to settings -> about > press on build number 7 times and the developer settings will be enable, go back to settings and press on developer mode and then enable USB DEBUGGING. If you found an android deviceon the street or something and want to break the pin this wont be possible unless you already know the pin so the device must have usb debugging enable for this to work. You wanna try this for fun then you can just enable usb debugging after you unlocked phone)

#### Via cli/adb: 

     settings put global development_settings_enabled 1
     setprop persist.service.adb.enable 1

#### Via GUI (old layout now use --androidgui 4 instead)
##### Please use cli method instead since many devices has been set to erase the device after "10/15 wrong pin attempts" and this wont happen with the CLI method. (Updated: Jan/2019)

![Screenshot](https://raw.githubusercontent.com/1939149/wbruter/master/files/wbruter.gif)

#### Via CLI:

From 0000 to 9999 takes ~83 minutes. In around ~1h you will with 100% _guarantee_ have the pin code

![Screenshot](https://nr1.nu/archive/wbruter/previews/wbruter-cli.gif)

#### Notice:

If you will see a message similiar to message under you don't have to care, just let it run and it will be gone after ~4-5 failed attempts: 

      Error while executing command: clear
        java.lang.RuntimeException: No data directory found for package android
        at android.app.ContextImpl.getDataDir(ContextImpl.java:2418)
        at android.app.ContextImpl.getPreferencesDir(ContextImpl.java:533)
        at android.app.ContextImpl.getSharedPreferencesPath(ContextImpl.java:795)
        at android.app.ContextImpl.getSharedPreferences(ContextImpl.java:394)
        at com.android.internal.widget.LockPatternUtils.monitorCheckPassword(LockPatternUtils.java:1814)
        at com.android.internal.widget.LockPatternUtils.checkCredential(LockPatternUtils.java:398)
        at com.android.internal.widget.LockPatternUtils.checkPassword(LockPatternUtils.java:548)
        at com.android.internal.widget.LockPatternUtils.checkPassword(LockPatternUtils.java:509)
        at com.android.server.LockSettingsShellCommand.checkCredential(LockSettingsShellCommand.java:151)
        at com.android.server.LockSettingsShellCommand.onCommand(LockSettingsShellCommand.java:57)
        at android.os.ShellCommand.exec(ShellCommand.java:96)
        at com.android.server.LockSettingsService.onShellCommand(LockSettingsService.java:1945)
        at android.os.Binder.shellCommand(Binder.java:574)
        at android.os.Binder.onTransact(Binder.java:474)
        at com.android.internal.widget.ILockSettings$Stub.onTransact(ILockSettings.java:419)
        at com.android.server.HwLockSettingsService.onTransact(HwLockSettingsService.java:179)
        at android.os.Binder.execTransact(Binder.java:675)


#### HOW TO

    git clone https://github.com/wuseman/WBRUTER
    cd WBRUTER; ./wbruter --help

#### REQUIREMENTS

A linux setup would be good ;)

#### CONTACT 

If you have problems, questions, ideas or suggestions please contact me by posting to wuseman@nr1.nu

#### WEB SITE

Visit my websites and profiles for the latest info and updated tools

https://github.com/wuseman/ && https://nr1.nu && https://stackoverflow.com/users/9887151/wuseman

#### END!
