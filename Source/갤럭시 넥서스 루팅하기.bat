@shift
@echo off
pushd %~dp0related
title ������ �ؼ��� �����ϱ� v38                    by joyfuI
mode con cols=80 lines=39
set boot_recovery=twrp-2.8.7.0-maguro.img

if not exist "..\related" (
cls
echo.
echo related ������ ã�� �� �����ϴ�.
echo ������ Ǯ�� �������ּ���.
pause > nul
exit
)

:Main
set menu=
cls
echo.
echo �� ���α׷����� ���� ���ش� å������ �ʽ��ϴ�!
echo ��� �� ������ �������ּ���~
echo.
echo         ����������������������������������������������������������������
echo         ����������������������������������������������������������������
echo         ���� F)   Fastboot�� ����     ���� R)   Recovery�� ����     ����
echo         ����������������������������������������������������������������
echo         ����������������������������������������������������������������
echo         ���� 1)                   ����̹� ��ġ                     ����
echo         ����������������������������������������������������������������
echo         ����������������������������������������������������������������
echo         ���� 2)               ��Ʈ�δ� UnLock/Lock                  ����
echo         ����������������������������������������������������������������
echo         ����������������������������������������������������������������
echo         ���� 3)           ��������(SuperUser) ��ġ/����             ����
echo         ����������������������������������������������������������������
echo         ����������������������������������������������������������������
echo         ���� 4)           ��Ŀ����(Recovery) ��ġ/����              ����
echo         ����������������������������������������������������������������
echo         ����������������������������������������������������������������
echo         ���� 5)        ��ġ���� �ʰ� ��Ŀ���� ���� ����           ����
echo         ����������������������������������������������������������������
echo         ����������������������������������������������������������������
echo         ���� 6)  �ؿ� ������ ��ġ     ���� 7)  ���� ������ ��ġ     ����
echo         ����������������������������������������������������������������
echo         ����������������������������������������������������������������
echo         ���� 8)                 ��Ÿ ������ ���                    ����
echo         ����������������������������������������������������������������
echo         ����������������������������������������������������������������
echo         ���� 0)       ��α�          ���� X)        ����           ����
echo         ����������������������������������������������������������������
echo         ����������������������������������������������������������������
echo.
set /p menu=���ϴ� ������ �Է� �� ����Ű�� �������� : 
if /i "%menu%"=="f" goto Fastboot
if /i "%menu%"=="r" goto Recovery
if /i "%menu%"=="1" goto USB_Driver
if /i "%menu%"=="2" goto BootLoader
if /i "%menu%"=="3" goto SuperUser
if /i "%menu%"=="4" goto Recovery_Installation
if /i "%menu%"=="5" goto Recovery_Boot
if /i "%menu%"=="6" goto Factory_Image
if /i "%menu%"=="7" goto Stock
if /i "%menu%"=="8" goto Extras
if /i "%menu%"=="0" start http://joyfui.wo.tc/
if /i "%menu%"=="x" adb kill-server & exit
goto Main

:Fastboot
cls
echo.
adb reboot bootloader
goto Main

:Recovery
cls
echo.
adb reboot recovery
goto Main

:USB_Driver
set menu=
cls
echo.
set /p menu=����̹� ��ġ�� �����Ͻðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" goto USB_Driver_Installation
if /i "%menu%"=="n" goto Main
goto USB_Driver

:USB_Driver_Installation
cls
echo.
echo ����̹� ��Ű�� ��ġ ��...
if /i "%PROCESSOR_ARCHITECTURE:~-2%"=="86" (
"..\Driver\DPInst_x86.exe"
) else if /i "%PROCESSOR_ARCHITECTURE:~-2%"=="64" (
"..\Driver\DPInst_x64.exe"
) else echo %PROCESSOR_ARCHITECTURE:~-2% & goto ERROR
echo.
echo �� ���� �����ؼ� Android 1.0 ����̹��� ��ġ�ϼ���.
echo http://joyfui.wo.tc/933
start http://joyfui.wo.tc/933
pause
goto Main

:BootLoader
set menu=
cls
echo.
echo [�߿�] UnLock �� ��� ������(SDī�� ����)�� �ʱ�ȭ�˴ϴ�!
echo.
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� U)              ��Ʈ�δ� UnLock                ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� L)               ��Ʈ�δ� Lock                 ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� B)                ��������...                  ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo.
set /p menu=���ϴ� ������ �Է� �� ����Ű�� �������� : 
if /i "%menu%"=="u" goto BootLoader_UnLock
if /i "%menu%"=="l" goto BootLoader_Lock
if /i "%menu%"=="b" goto Main
goto BootLoader

:BootLoader_UnLock
set menu=
cls
echo.
set /p menu=��Ʈ�δ� UnLock �� ��� ������(SDī�� ����)�� �ʱ�ȭ�˴ϴ�. ���� �����Ͻðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" (
cls
echo.
adb reboot bootloader
cls
echo.
ping -n 6 127.0.0.1 > nul
echo ������ �ؼ����� ���â�� �߸�
echo ���� ��ư���� Yes�� �����ϰ� ���� ��ư�� �����ּ���.
echo.
fastboot oem unlock
if errorlevel 1 goto ERROR
echo.
echo ��Ʈ�δ� ����� �Ϸ�Ǿ����ϴ�.
pause
goto Main
)
if /i "%menu%"=="n" goto BootLoader
goto BootLoader_UnLock

:BootLoader_Lock
set menu=
cls
echo.
set /p menu=��Ʈ�δ��� �ٽ� Lock�մϴ�. ���� �����Ͻðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" (
cls
echo.
adb reboot bootloader
cls
echo.
ping -n 6 127.0.0.1 > nul
fastboot oem lock
if errorlevel 1 goto ERROR
echo.
echo ��Ʈ�δ� ���� �Ϸ�Ǿ����ϴ�.
pause
goto Main
)
if /i "%menu%"=="n" goto BootLoader
goto BootLoader_Lock

:SuperUser
set menu=
cls
echo.
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 1)        SuperSU (by Chainfire) ��ġ          ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 2)         Superuser (by koush) ��ġ           ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 3)       Superuser (by ChainsDD) ��ġ          ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 4)         SimpleSU (by _n0p_) ��ġ            ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� U)               �������� ����                 ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� B)                ��������...                  ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo.
set /p menu=���ϴ� ������ �Է� �� ����Ű�� �������� : 
if /i "%menu%"=="1" goto SuperSU_Chainfire
if /i "%menu%"=="2" goto Superuser_koush
if /i "%menu%"=="3" goto Superuser_ChainsDD
if /i "%menu%"=="4" goto SimpleSU__n0p_
if /i "%menu%"=="u" goto SuperUser_Uninstallation
if /i "%menu%"=="b" goto Main
goto SuperUser

:SuperSU_Chainfire
set menu=
cls
echo.
set /p menu=SuperSU�� ��ġ�մϴ�. ���� �����Ͻðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" (
cls
echo.
adb reboot bootloader
cls
echo.
ping -n 6 127.0.0.1 > nul
fastboot boot %boot_recovery%
echo.
echo ��Ʈ������ ���� ���� ��Ŀ������ ���õ˴ϴ�.
echo ��ø� ��ٷ��ּ���.
if errorlevel 1 goto ERROR
ping -n 31 127.0.0.1 > nul
cls
echo.
echo ��Ʈ���� ȹ�� �� ��Ƽ�� ����Ʈ ��...
adb root
adb remount
adb shell mount /system
echo ���� ���� ��...
adb shell mkdir /system/bin/.ext
adb push SuperSU_Chainfire-su /system/bin/.ext/.su
adb push SuperSU_Chainfire-su /system/xbin/su
adb push SuperSU_Chainfire-su /system/xbin/daemonsu
adb push SuperSU_Chainfire-su /system/xbin/sugote
adb shell cp /system/bin/mksh /system/xbin/sugote-mksh
adb push SuperSU246_Chainfire.apk /system/app/Superuser.apk
adb push SuperSU_Chainfire-install-recovery.sh /system/etc/install-recovery.sh
adb push SuperSU_Chainfire-99SuperSUDaemon /system/etc/init.d/99SuperSUDaemon
adb shell echo 1 > /system/etc/.installed_su_daemon
echo �۹̼� ���� ��...
adb shell chown 0.0 /system/bin/.ext
adb shell chown 0:0 /system/bin/.ext
adb shell chmod 0777 /system/bin/.ext
adb shell chown 0.0 /system/bin/.ext/.su
adb shell chown 0:0 /system/bin/.ext/.su
adb shell chmod 0755 /system/bin/.ext/.su
adb shell chown 0.0 /system/xbin/su
adb shell chown 0:0 /system/xbin/su
adb shell chmod 0755 /system/xbin/su
adb shell chown 0.0 /system/xbin/sugote
adb shell chown 0:0 /system/xbin/sugote
adb shell chmod 0755 /system/xbin/sugote
adb shell chown 0.0 /system/xbin/sugote-mksh
adb shell chown 0:0 /system/xbin/sugote-mksh
adb shell chmod 0755 /system/xbin/sugote-mksh
adb shell chown 0.0 /system/xbin/daemonsu
adb shell chown 0:0 /system/xbin/daemonsu
adb shell chmod 0755 /system/xbin/daemonsu
adb shell chown 0.0 /system/etc/install-recovery.sh
adb shell chown 0:0 /system/etc/install-recovery.sh
adb shell chmod 0755 /system/etc/install-recovery.sh
adb shell chown 0.0 /system/etc/init.d/99SuperSUDaemon
adb shell chown 0:0 /system/etc/init.d/99SuperSUDaemon
adb shell chmod 0755 /system/etc/init.d/99SuperSUDaemon
adb shell chown 0.0 /system/etc/.installed_su_daemon
adb shell chown 0:0 /system/etc/.installed_su_daemon
adb shell chmod 0644 /system/etc/.installed_su_daemon
adb shell chown 0.0 /system/app/Superuser.apk
adb shell chown 0:0 /system/app/Superuser.apk
adb shell chmod 0644 /system/app/Superuser.apk
adb shell chcon u:object_r:system_file:s0 /system/bin/.ext/.su
adb shell chcon u:object_r:system_file:s0 /system/xbin/su
adb shell chcon u:object_r:zygote_exec:s0 /system/xbin/sugote
adb shell chcon u:object_r:system_file:s0 /system/xbin/sugote-mksh
adb shell chcon u:object_r:system_file:s0 /system/xbin/daemonsu
adb shell chcon u:object_r:system_file:s0 /system/etc/install-recovery.sh
adb shell chcon u:object_r:system_file:s0 /system/etc/init.d/99SuperSUDaemon
adb shell chcon u:object_r:system_file:s0 /system/etc/.installed_su_daemon
adb shell chcon u:object_r:system_file:s0 /system/app/Superuser.apk
echo �ɺ��� ��ũ ���� ��...
adb shell ln -s /system/etc/install-recovery.sh /system/bin/install-recovery.sh
echo ��ġ �� ��ũ��Ʈ ���� ��...
adb shell /system/xbin/su --install
echo ����� ��...
adb reboot
if errorlevel 1 goto ERROR
echo.
echo SuperSU ��ġ�� �Ϸ�Ǿ����ϴ�.
pause
goto Main
)
if /i "%menu%"=="n" goto SuperUser
goto SuperSU_Chainfire

:Superuser_koush
set menu=
cls
echo.
set /p menu=Superuser�� ��ġ�մϴ�. ���� �����Ͻðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" (
cls
echo.
adb reboot bootloader
cls
echo.
ping -n 6 127.0.0.1 > nul
fastboot boot %boot_recovery%
echo.
echo ��Ʈ������ ���� ���� ��Ŀ������ ���õ˴ϴ�.
echo ��ø� ��ٷ��ּ���.
if errorlevel 1 goto ERROR
ping -n 31 127.0.0.1 > nul
cls
echo.
echo ��Ʈ���� ȹ�� �� ��Ƽ�� ����Ʈ ��...
adb root
adb remount
adb shell mount /system
echo ���� ���� ��...
adb push Superuser_koush-su /system/xbin/su
adb push Superuser1030_koush.apk /system/app/Superuser.apk
adb push Superuser_koush-install-recovery.sh /system/etc/install-recovery.sh
adb shell touch /system/etc/.installed_su_daemon
echo �۹̼� ���� ��...
adb shell chown 0:0 /system/xbin/su
adb shell chmod 6755 /system/xbin/su
adb shell chmod 644 /system/app/Superuser.apk
adb shell chmod 755 /system/etc/install-recovery.sh
echo �ɺ��� ��ũ ���� ��...
adb shell ln -s /system/xbin/su /system/bin/su
echo ����� ��...
adb reboot
if errorlevel 1 goto ERROR
echo.
echo Superuser ��ġ�� �Ϸ�Ǿ����ϴ�.
pause
goto Main
)
if /i "%menu%"=="n" goto SuperUser
goto Superuser_koush

:Superuser_ChainsDD
set menu=
cls
echo.
echo 4.2���� �������� �ʽ��ϴ�!
set /p menu=Superuser�� ��ġ�մϴ�. ���� �����Ͻðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" (
cls
echo.
adb reboot bootloader
cls
echo.
ping -n 6 127.0.0.1 > nul
fastboot boot %boot_recovery%
echo.
echo ��Ʈ������ ���� ���� ��Ŀ������ ���õ˴ϴ�.
echo ��ø� ��ٷ��ּ���.
if errorlevel 1 goto ERROR
ping -n 31 127.0.0.1 > nul
cls
echo.
echo ��Ʈ���� ȹ�� �� ��Ƽ�� ����Ʈ ��...
adb root
adb remount
adb shell mount /system
echo ���� ���� ��...
adb push Superuser_ChainsDD-su /system/bin/su
adb push Superuser313_ChainsDD.apk /system/app/Superuser.apk
echo �۹̼� ���� ��...
adb shell chown 0:0 /system/bin/su
adb shell chmod 06755 /system/bin/su
echo �ɺ��� ��ũ ���� ��...
adb shell ln -s /system/bin/su /system/xbin/su
echo ����� ��...
adb reboot
if errorlevel 1 goto ERROR
echo.
echo Superuser ��ġ�� �Ϸ�Ǿ����ϴ�.
pause
goto Main
)
if /i "%menu%"=="n" goto SuperUser
goto Superuser_ChainsDD

:SimpleSU__n0p_
set menu=
cls
echo.
echo 4.3���� �������� �ʽ��ϴ�!
set /p menu=SimpleSU�� ��ġ�մϴ�. ���� �����Ͻðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" (
cls
echo.
adb reboot bootloader
cls
echo.
ping -n 6 127.0.0.1 > nul
fastboot boot %boot_recovery%
echo.
echo ��Ʈ������ ���� ���� ��Ŀ������ ���õ˴ϴ�.
echo ��ø� ��ٷ��ּ���.
if errorlevel 1 goto ERROR
ping -n 31 127.0.0.1 > nul
cls
echo.
echo ��Ʈ���� ȹ�� �� ��Ƽ�� ����Ʈ ��...
adb root
adb remount
adb shell mount /system
echo ���� ���� ��...
adb push SimpleSU__n0p_-su /system/xbin/su
adb push dsc.su_list /system/etc/dsc.su_list
echo �۹̼� ���� ��...
adb shell chmod 6755 /system/xbin/su
adb shell chown root.root /system/etc/dsc.su_list
adb shell chmod 644 /system/etc/dsc.su_list
echo ���ø����̼� ��ġ ��...
adb install DSC_SimpleSU_ACL.apk
echo ����� ��...
adb reboot
if errorlevel 1 goto ERROR
echo.
echo SimpleSU ��ġ�� �Ϸ�Ǿ����ϴ�.
pause
goto Main
)
if /i "%menu%"=="n" goto SuperUser
goto SimpleSU__n0p_

:SuperUser_Uninstallation
set menu=
cls
echo.
set /p menu=��������(SuperUser)�� �����մϴ�. ���� �����Ͻðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" (
cls
echo.
adb reboot bootloader
cls
echo.
ping -n 6 127.0.0.1 > nul
fastboot boot %boot_recovery%
echo.
echo ��Ʈ������ ���� ���� ��Ŀ������ ���õ˴ϴ�.
echo ��ø� ��ٷ��ּ���.
if errorlevel 1 goto ERROR
ping -n 31 127.0.0.1 > nul
cls
echo.
echo ��Ʈ���� ȹ�� �� ��Ƽ�� ����Ʈ ��...
adb root
adb remount
adb shell mount /system
adb shell mount /data
echo �۹̼� ���� ��...
adb shell chattr -i /system/xbin/su
adb shell chattr -i /system/bin/su
adb shell chattr -i /system/bin/.ext/.su
adb shell chattr -i /system/xbin/daemonsu
adb shell chattr -i /system/xbin/sugote
adb shell chattr -i /system/xbin/sugote_mksh
adb shell chattr -i /system/xbin/supolicy
adb shell chattr -i /system/etc/install-recovery.sh
adb shell chattr -i /system/bin/install-recovery.sh
echo �������� �������� ���� ��...
adb shell rm -rf /system/xbin/su
adb shell rm -rf /system/bin/su
adb shell rm -rf /system/xbin/daemonsu
adb shell rm -rf /system/xbin/sugote
adb shell rm -rf /system/xbin/sugote-mksh
adb shell rm -rf /system/xbin/supolicy
adb shell rm -rf /system/bin/.ext
adb shell rm -rf /system/bin/install-recovery.sh
adb shell rm -rf /system/etc/install-recovery.sh
adb shell rm -rf /system/etc/init.d/99SuperSUDaemon
adb shell rm -rf /system/etc/.installed_su_daemon
adb shell rm -rf /system/app/SuperSU.*
adb shell rm -rf /system/app/Supersu.*
adb shell rm -rf /system/app/supersu.*
adb shell rm -rf /system/app/SuperUser.*
adb shell rm -rf /system/app/Superuser.*
adb shell rm -rf /system/app/superuser.*
adb shell rm -rf /system/app/VenomSuperUser.*
adb shell rm -rf /data/app/eu.chainfire.supersu*
adb shell rm -rf /data/app/com.koushikdutta.superuser*
adb shell rm -rf /data/app/com.noshufou.android.su*
adb shell rm -rf /data/app/com.mgyun.shua.su*
adb shell rm -rf /data/app/com.m0narx.su*
adb shell rm -rf /data/data/eu.chainfire.supersu
adb shell rm -rf /data/data/com.koushikdutta.superuser
adb shell rm -rf /data/data/com.noshufou.android.su
adb shell rm -rf /data/data/com.mgyun.shua.su
adb shell rm -rf /data/data/com.m0narx.su
adb shell rm -rf /data/dalvik-cache/*eu.chainfire.supersu*
adb shell rm -rf /data/dalvik-cache/*com.koushikdutta.superuser*
adb shell rm -rf /data/dalvik-cache/*com.noshufou.android.su*
adb shell rm -rf /data/dalvik-cache/*com.mgyun.shua.su*
adb shell rm -rf /data/dalvik-cache/*com.m0narx.su*
adb shell rm -rf /data/dalvik-cache/*SuperSU*
adb shell rm -rf /data/dalvik-cache/*Supersu*
adb shell rm -rf /data/dalvik-cache/*supersu*
adb shell rm -rf /data/dalvik-cache/*SuperUser*
adb shell rm -rf /data/dalvik-cache/*Superuser*
adb shell rm -rf /data/dalvik-cache/*superuser*
adb shell rm -rf /data/dalvik-cache/*.oat
adb shell rm -rf /system/etc/dsc.su_list
echo ����� ��...
adb reboot
if errorlevel 1 goto ERROR
echo.
echo �������� ������ �Ϸ�Ǿ����ϴ�.
pause
goto Main
)
if /i "%menu%"=="n" goto SuperUser
goto SuperUser_Uninstallation

:Recovery_Installation
set menu=
cls
echo.
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 1)           TeamWin Recovery ��ġ             ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 2)        ClockworkMod Recovery ��ġ           ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 3)     ClockworkMod Touch Recovery ��ġ        ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 4)         PhilZ Touch Recovery ��ġ           ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 5)     TeamWin Recovery (F2FS ����) ��ġ       ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 6)            ���� ��Ŀ���� ��ġ               ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� D)          ��Ŀ���� �ڵ� ���� ����            ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� B)                ��������...                  ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo.
set /p menu=���ϴ� ������ �Է� �� ����Ű�� �������� : 
if /i "%menu%"=="1" (
set recovery=twrp-2.8.7.0-maguro.img
set recovery_name=TeamWin
goto Go_Recovery_Installation
)
if /i "%menu%"=="2" (
set recovery=recovery-clockwork-6.0.4.7-maguro.img
set recovery_name=CWM
goto Go_Recovery_Installation
)
if /i "%menu%"=="3" (
set recovery=recovery-clockwork-touch-6.0.4.7-maguro.img
set recovery_name=Touch CWM
goto Go_Recovery_Installation
)
if /i "%menu%"=="4" (
set recovery=philz_touch_6.19.3-maguro.img
set recovery_name=PhilZ
goto Go_Recovery_Installation
)
if /i "%menu%"=="5" (
set recovery=twrp-2.8.6.0-maguro-f2fs.img
set recovery_name=TeamWin
goto Go_Recovery_Installation
)
if /i "%menu%"=="6" (
set recovery=recovery-stock.img
set recovery_name=����
goto Go_Recovery_Installation
)
if /i "%menu%"=="d" goto Remove_Recovery
if /i "%menu%"=="b" goto Main
goto Recovery_Installation

:Go_Recovery_Installation
set menu=
cls
echo.
set /p menu=%recovery_name% ��Ŀ������ ��ġ�մϴ�. ���� �����Ͻðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" (
cls
echo.
adb reboot bootloader
cls
echo.
ping -n 6 127.0.0.1 > nul
fastboot flash recovery %recovery%
if errorlevel 1 goto ERROR
echo.
echo %recovery_name% ��Ŀ���� ��ġ�� �Ϸ�Ǿ����ϴ�.
pause
goto Remove_Recovery
)
if /i "%menu%"=="n" goto Recovery_Installation
goto Go_Recovery_Installation

:Remove_Recovery
set menu=
cls
echo.
echo �����ҿ����� ���� �� �ڵ����� ���� ��Ŀ������ ���ƿɴϴ�. Ŀ���ҷҿ����� �ѱ�ŵ� �˴ϴ�.
set /p menu=��Ŀ���� �ڵ� ���� ������ �����ұ��? (Y/N) : 
if /i "%menu%"=="y" (
cls
echo.
ping -n 6 127.0.0.1 > nul
fastboot boot %boot_recovery%
echo.
echo ��Ʈ������ ���� ���� ��Ŀ������ ���õ˴ϴ�.
echo ��ø� ��ٷ��ּ���.
if errorlevel 1 goto ERROR
ping -n 31 127.0.0.1 > nul
cls
echo.
echo ��Ʈ���� ȹ�� �� ��Ƽ�� ����Ʈ ��...
adb root
adb remount
adb shell mount /system
echo ���� ���� ��...
adb shell rm -rf /system/recovery-from-boot.p
adb shell rm -rf /system/etc/install-recovery.sh
echo ����� ��...
adb reboot
if errorlevel 1 goto ERROR
goto Main
)
if /i "%menu%"=="n" goto Recovery_Installation
goto Remove_Recovery

:Recovery_Boot
set menu=
cls
echo.
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 1)          TeamWin Recovery�� ����            ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 2)       ClockworkMod Recovery�� ����          ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 3)    ClockworkMod Touch Recovery�� ����       ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 4)        PhilZ Touch Recovery�� ����          ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 5)    TeamWin Recovery (F2FS ����)�� ����      ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 6)           ���� ��Ŀ������ ����              ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� B)                ��������...                  ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo.
set /p menu=���ϴ� ������ �Է� �� ����Ű�� �������� : 
if /i "%menu%"=="1" (
set recovery=twrp-2.8.7.0-maguro.img
set recovery_name=TeamWin
goto Go_Recovery_Boot
)
if /i "%menu%"=="2" (
set recovery=recovery-clockwork-6.0.4.7-maguro.img
set recovery_name=CWM
goto Go_Recovery_Boot
)
if /i "%menu%"=="3" (
set recovery=recovery-clockwork-touch-6.0.4.7-maguro.img
set recovery_name=Touch CWM
goto Go_Recovery_Boot
)
if /i "%menu%"=="4" (
set recovery=philz_touch_6.19.3-maguro.img
set recovery_name=PhilZ
goto Go_Recovery_Boot
)
if /i "%menu%"=="5" (
set recovery=twrp-2.8.6.0-maguro-f2fs.img
set recovery_name=TeamWin
goto Go_Recovery_Boot
)
if /i "%menu%"=="6" (
set recovery=recovery-stock.img
set recovery_name=����
goto Go_Recovery_Boot
)
if /i "%menu%"=="b" goto Main
goto Recovery_Boot

:Go_Recovery_Boot
set menu=
cls
echo.
set /p menu=%recovery_name% ��Ŀ������ ��ġ���� �ʰ� %recovery_name% ��Ŀ������ �����մϴ�. ���� �����Ͻðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" (
cls
echo.
adb reboot bootloader
cls
echo.
ping -n 6 127.0.0.1 > nul
fastboot boot %recovery%
if errorlevel 1 goto ERROR
goto Main
)
if /i "%menu%"=="n" goto Recovery_Boot
goto Go_Recovery_Boot

:Factory_Image
set menu=
cls
echo.
echo ��Ʈ�δ� ����� �Ǿ� �־�� �մϴ�~
echo.
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 1)           yakju 4.0.4 (IMM76I)              ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 2)           yakju 4.1.2 (JZO54K)              ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 3)            yakju 4.2.2 (JDQ39)              ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 4)            yakju 4.3 (JWR66Y)               ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 5)           takju 4.0.4 (IMM76I)              ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 6)           takju 4.1.2 (JZO54K)              ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 7)            takju 4.2.2 (JDQ39)              ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 8)            takju 4.3 (JWR66Y)               ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� B)                ��������...                  ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo.
set /p menu=���ϴ� ������ �Է� �� ����Ű�� �������� : 
if /i "%menu%"=="1" (
set image=yakju-imm76i-factory-8001e72f
set image_folder=yakju-imm76i
set image_rom=yakju
goto Factory_Image_Installation
)
if /i "%menu%"=="2" (
set image=yakju-jzo54k-factory-92ff9457
set image_folder=yakju-jzo54k
set image_rom=yakju
goto Factory_Image_Installation
)
if /i "%menu%"=="3" (
set image=yakju-jdq39-factory-b2ebb5f3
set image_folder=yakju-jdq39
set image_rom=yakju
goto Factory_Image_Installation
)
if /i "%menu%"=="4" (
set image=yakju-jwr66y-factory-09207065
set image_folder=yakju-jwr66y
set image_rom=yakju
goto Factory_Image_Installation
)
if /i "%menu%"=="5" (
set image=takju-imm76i-factory-e8c33767
set image_folder=takju-imm76i
set image_rom=takju
goto Factory_Image_Installation
)
if /i "%menu%"=="6" (
set image=takju-jzo54k-factory-92830c0b
set image_folder=takju-jzo54k
set image_rom=takju
goto Factory_Image_Installation
)
if /i "%menu%"=="7" (
set image=takju-jdq39-factory-5e273f02
set image_folder=takju-jdq39
set image_rom=takju
goto Factory_Image_Installation
)
if /i "%menu%"=="8" (
set image=takju-jwr66y-factory-5104ab1d
set image_folder=takju-jwr66y
set image_rom=takju
goto Factory_Image_Installation
)
if /i "%menu%"=="b" goto Main
goto Factory_Image

:Factory_Image_Installation
set menu=
cls
echo.
set /p menu=�ؿ� ������ ��ġ �� ��� �����Ͱ� �ʱ�ȭ�˴ϴ�. ���� �����Ͻðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" goto Factory_Image_Download
if /i "%menu%"=="n" goto Factory_Image
goto Factory_Image_Installation

:Factory_Image_Download
set menu=
if exist "..\Image\%image%.tgz" goto Factory_Image_Data
cls
echo.
set /p menu=��ġ �̹��� ������ �߰ߵ��� �ʾҽ��ϴ�. ���������ðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" (
cls
echo.
wget.exe --no-check-certificate -t 2 -P ..\Image https://dl.google.com/dl/android/aosp/%image%.tgz
if not exist "..\Image\%image%.tgz" wget.exe -t 2 -P ..\Image http://goo.im/devs/WugFresh/stock/maguro/%image_rom%/%image%.tgz
if errorlevel 1 goto ERROR
echo �ٿ�ε尡 �Ϸ�Ǿ����ϴ�.
pause
goto Factory_Image_Data
)
if /i "%menu%"=="n" goto Factory_Image
goto Factory_Image_Download

:Factory_Image_Data
set menu=
cls
echo.
set /p menu=SDī�� �����ͱ��� �ʱ�ȭ�ϰ� ��ġ�Ͻðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" (
cls
echo.
echo ���� ���� ��...
7za.exe x ..\Image\%image%.tgz -o..\Image
7za.exe x ..\Image\%image%.tar -o..\Image
if errorlevel 1 goto ERROR
del ..\Image\%image%.tar
cls
echo.
adb reboot bootloader
cls
echo.
ping -n 6 127.0.0.1 > nul
echo ��Ʈ�δ� �÷��� ��...
fastboot flash bootloader ..\Image\%image_folder%\bootloader-maguro-*.img
if errorlevel 1 goto ERROR
echo ��Ʈ�δ� ����� ��...
fastboot reboot-bootloader
ping -n 6 127.0.0.1 > nul
echo ���� �÷��� ��...
fastboot flash radio ..\Image\%image_folder%\radio-maguro-*.img
if errorlevel 1 goto ERROR
echo ��Ʈ�δ� ����� ��...
fastboot reboot-bootloader
ping -n 6 127.0.0.1 > nul
echo �̹��� ���� �÷��� ��...
fastboot -w update ..\Image\%image_folder%\image-*.zip
if errorlevel 1 goto ERROR
echo ���� ������ ���� ���� ��...
rmdir /s /q ..\Image\%image_folder%
echo.
echo �ؿ� ������ ��ġ�� �Ϸ�Ǿ����ϴ�.
pause
goto Remove_Factory_Image
)
if /i "%menu%"=="n" (
cls
echo.
echo ���� ���� ��...
7za.exe x ..\Image\%image%.tgz -o..\Image
7za.exe x ..\Image\%image%.tar -o..\Image
if errorlevel 1 goto ERROR
del ..\Image\%image%.tar
7za.exe x ..\Image\%image_folder%\image-*.zip -o..\Image\%image_folder%
if errorlevel 1 goto ERROR
cls
echo.
adb reboot bootloader
cls
echo.
ping -n 6 127.0.0.1 > nul
fastboot boot %boot_recovery%
echo.
echo ��Ʈ������ ���� ���� ��Ŀ������ ���õ˴ϴ�.
echo ��ø� ��ٷ��ּ���.
if errorlevel 1 goto ERROR
ping -n 31 127.0.0.1 > nul
cls
echo.
echo ��Ʈ���� ȹ�� �� ��Ƽ�� ����Ʈ ��...
adb root
adb remount
adb shell mount /data
echo ���� ���� ��...
adb push exclude.sh /tmp/exclude.sh
adb push bash /tmp/bash
echo �۹̼� ���� ��...
adb shell chmod 0777 /tmp/exclude.sh
adb shell chmod 0777 /tmp/bash
echo ������ ��Ƽ�� ���� ��...
adb shell /tmp/exclude.sh
echo ������ ���� ���� ��...
adb shell rm -r /tmp/exclude.sh
adb shell rm -r /tmp/bash
echo ��Ʈ�δ��� ����� ��...
adb reboot bootloader
if errorlevel 1 goto ERROR
ping -n 6 127.0.0.1 > nul
echo ĳ�� ��Ƽ�� ���� ��...
fastboot erase cache
echo ��Ʈ�δ� �÷��� ��...
fastboot flash bootloader ..\Image\%image_folder%\bootloader-maguro-*.img
if errorlevel 1 goto ERROR
echo ��Ʈ�δ� ����� ��...
fastboot reboot-bootloader
ping -n 6 127.0.0.1 > nul
echo ���� �÷��� ��...
fastboot flash radio ..\Image\%image_folder%\radio-maguro-*.img
if errorlevel 1 goto ERROR
echo ��Ʈ�δ� ����� ��...
fastboot reboot-bootloader
ping -n 6 127.0.0.1 > nul
echo ��Ʈ ���� �÷��� ��...
fastboot flash boot ..\Image\%image_folder%\boot.img
if errorlevel 1 goto ERROR
echo ��Ŀ���� ���� �÷��� ��...
fastboot flash recovery ..\Image\%image_folder%\recovery.img
if errorlevel 1 goto ERROR
echo �ý��� ���� �÷��� ��...
fastboot flash system ..\Image\%image_folder%\system.img
if errorlevel 1 goto ERROR
echo ���� ������ ���� ���� ��...
rmdir /s /q ..\Image\%image_folder%
echo ����� ��...
fastboot reboot
if errorlevel 1 goto ERROR
echo.
echo �ؿ� ������ ��ġ�� �Ϸ�Ǿ����ϴ�.
pause
goto Remove_Factory_Image
)
goto Factory_Image_Data

:Remove_Factory_Image
set menu=
cls
echo.
set /p menu=�������� �̹��� ������ �����Ͻðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" del ..\Image\%image%.tgz & goto Main
if /i "%menu%"=="n" goto Main
goto Remove_Factory_Image

:Stock
set menu=
cls
echo.
echo ��Ʈ�δ� ����� �Ǿ� �־�� �մϴ�~
echo 4.0.4 (IMM76K)�Դϴ�.
echo.
set /p menu=���� ������ ��ġ �� ��� �����Ͱ� �ʱ�ȭ�˴ϴ�. ���� �����Ͻðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" goto Stock_Download
if /i "%menu%"=="n" goto Main
goto Stock

:Stock_Download
set menu=
if exist "..\Image\Factory_KOR_4.0.4_Say.zip" goto Stock_Data
cls
echo.

echo ���������� ������ �������� �ʽ��ϴ�.
pause
goto Main

set /p menu=��ġ �̹��� ������ �߰ߵ��� �ʾҽ��ϴ�. ���������ðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" (
cls
echo.
wget.exe -t 2 -P ..\Image http://turbohost.iptime.org:5/SmartPhone/NEXUS/Factory_KOR_4.0.4_Say.zip
if errorlevel 1 goto ERROR
echo �ٿ�ε尡 �Ϸ�Ǿ����ϴ�.
pause
goto Stock_Data
)
if /i "%menu%"=="n" goto Main
goto Stock_Download

:Stock_Data
set menu=
cls
echo.
set /p menu=SDī�� �����ͱ��� �ʱ�ȭ�ϰ� ��ġ�Ͻðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" (
cls
echo.
echo ���� ���� ��...
7za.exe x ..\Image\Factory_KOR_4.0.4_Say.zip -o..\Image\Factory_KOR_4.0.4_Say
if errorlevel 1 goto ERROR
cls
echo.
adb reboot bootloader
cls
echo.
ping -n 6 127.0.0.1 > nul
echo ��Ʈ�δ� �÷��� ��...
fastboot flash bootloader ..\Image\Factory_KOR_4.0.4_Say\bootloader.img
if errorlevel 1 goto ERROR
echo ��Ʈ�δ� ����� ��...
fastboot reboot-bootloader
ping -n 6 127.0.0.1 > nul
echo ���� �÷��� ��...
fastboot flash radio ..\Image\Factory_KOR_4.0.4_Say\radio.img
if errorlevel 1 goto ERROR
echo ��Ʈ�δ� ����� ��...
fastboot reboot-bootloader
ping -n 6 127.0.0.1 > nul
echo �̹��� ���� �÷��� ��...
fastboot -w update ..\Image\Factory_KOR_4.0.4_Say\factory_kor_stock_say.zip
if errorlevel 1 goto ERROR
echo.
echo ���� ������ ��ġ�� �Ϸ�Ǿ����ϴ�.
pause
goto Remove_Stock
)
if /i "%menu%"=="n" (
cls
echo.
echo ���� ���� ��...
7za.exe x ..\Image\Factory_KOR_4.0.4_Say.zip -o..\Image\Factory_KOR_4.0.4_Say
7za.exe x ..\Image\Factory_KOR_4.0.4_Say\factory_kor_stock_say.zip -o..\Image\Factory_KOR_4.0.4_Say
if errorlevel 1 goto ERROR
cls
echo.
adb reboot bootloader
cls
echo.
ping -n 6 127.0.0.1 > nul
fastboot boot %boot_recovery%
echo.
echo ��Ʈ������ ���� ���� ��Ŀ������ ���õ˴ϴ�.
echo ��ø� ��ٷ��ּ���.
if errorlevel 1 goto ERROR
ping -n 31 127.0.0.1 > nul
cls
echo.
echo ��Ʈ���� ȹ�� �� ��Ƽ�� ����Ʈ ��...
adb root
adb remount
adb shell mount /data
echo ���� ���� ��...
adb push exclude.sh /tmp/exclude.sh
adb push bash /tmp/bash
echo �۹̼� ���� ��...
adb shell chmod 0777 /tmp/exclude.sh
adb shell chmod 0777 /tmp/bash
echo ������ ��Ƽ�� ���� ��...
adb shell /tmp/exclude.sh
echo ������ ���� ���� ��...
adb shell rm -r /tmp/exclude.sh
adb shell rm -r /tmp/bash
echo ��Ʈ�δ��� ����� ��...
adb reboot bootloader
if errorlevel 1 goto ERROR
ping -n 6 127.0.0.1 > nul
echo ĳ�� ��Ƽ�� ���� ��...
fastboot erase cache
echo ��Ʈ�δ� �÷��� ��...
fastboot flash bootloader ..\Image\Factory_KOR_4.0.4_Say\bootloader.img
if errorlevel 1 goto ERROR
echo ��Ʈ�δ� ����� ��...
fastboot reboot-bootloader
ping -n 6 127.0.0.1 > nul
echo ���� �÷��� ��...
fastboot flash radio ..\Image\Factory_KOR_4.0.4_Say\radio.img
if errorlevel 1 goto ERROR
echo ��Ʈ�δ� ����� ��...
fastboot reboot-bootloader
ping -n 6 127.0.0.1 > nul
echo ��Ʈ ���� �÷��� ��...
fastboot flash boot ..\Image\Factory_KOR_4.0.4_Say\boot.img
if errorlevel 1 goto ERROR
echo ��Ŀ���� ���� �÷��� ��...
fastboot flash recovery ..\Image\Factory_KOR_4.0.4_Say\recovery.img
if errorlevel 1 goto ERROR
echo �ý��� ���� �÷��� ��...
fastboot flash system ..\Image\Factory_KOR_4.0.4_Say\system.img
if errorlevel 1 goto ERROR
echo ���� ������ ���� ���� ��...
rmdir /s /q ..\Image\Factory_KOR_4.0.4_Say
echo ����� ��...
fastboot reboot
if errorlevel 1 goto ERROR
echo.
echo ���� ������ ��ġ�� �Ϸ�Ǿ����ϴ�.
pause
goto Remove_Stock
)
goto Stock_Data

:Remove_Stock

goto Main

set menu=
cls
echo.
set /p menu=�������� �̹��� ������ �����Ͻðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" del ..\Image\Factory_KOR_4.0.4_Say.zip & goto Main
if /i "%menu%"=="n" goto Main
goto Remove_Stock

:Extras
set menu=
cls
echo.
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 1)          ���ø����̼� ���/����             ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 2)           img, zip ���� �÷���              ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 3)        �����ڽ�(Busybox) ��ġ/����          ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 4)              IMEI ���/����                 ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 5)           �ȵ���̵� ��ȣ ����              ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� 6)              ����(Odin) ����                ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo             ���� B)                ��������...                  ����
echo             ��������������������������������������������������������
echo             ��������������������������������������������������������
echo.
set /p menu=���ϴ� ������ �Է� �� ����Ű�� �������� : 
if /i "%menu%"=="1" goto Backup
if /i "%menu%"=="2" goto Flash
if /i "%menu%"=="3" goto Busybox
if /i "%menu%"=="4" goto IMEI
if /i "%menu%"=="5" goto Password
if /i "%menu%"=="6" start "" "Odin3_v3.07.exe"
if /i "%menu%"=="b" goto Main
goto Extras

:Backup
set menu=
cls
echo.
echo �Ϲ� ���� ���·� �������ּ���.
echo �����氳���� �ɼǿ��� "USB �����"�� üũ�� �ʼ��Դϴ�!
echo.
echo                 ������������������������������������������������
echo                 ������������������������������������������������
echo                 ���� 1)  �ý��� ���� �����ϰ� ��� ���     ����
echo                 ������������������������������������������������
echo                 ������������������������������������������������
echo                 ���� 2)      �ý��� �۱��� ��� ���        ����
echo                 ������������������������������������������������
echo                 ������������������������������������������������
echo                 ���� 3)         ������ �۸� ���            ����
echo                 ������������������������������������������������
echo                 ������������������������������������������������
echo                 ���� 4)               ����                  ����
echo                 ������������������������������������������������
echo                 ������������������������������������������������
echo                 ���� B)              �ڷ�...                ����
echo                 ������������������������������������������������
echo                 ������������������������������������������������
echo.
set /p menu=���ϴ� ������ �Է� �� ����Ű�� �������� : 
if /i "%menu%"=="1" goto All_Backup
if /i "%menu%"=="2" goto System_Backup
if /i "%menu%"=="3" goto Single_Backup
if /i "%menu%"=="4" goto Restore
if /i "%menu%"=="b" goto Extras
goto Backup

:All_Backup
cls
echo.
echo �ý��� ���� ������ ��� ���� ����մϴ�.
echo SDī�忡 ����� �� �����ʹ� ������� ������ ���� ����صμ���.
echo.
echo ������ �ؼ����� �� �ȳ���� "������ ���" ��ư�� �����ּ���.
echo ��ġ�� ���� �������� ���� �ɸ��ϴ�.
echo.
set file=%date%--%time:~0,2%-%time:~3,2%_nosystemBackup.ab
adb backup -f "..\%file%" -apk -noobb -noshared -all -nosystem
if errorlevel 1 goto ERROR
start "" "explorer.exe" %~dp0
echo.
echo ����� �Ϸ�Ǿ����ϴ�.
echo %file% ������ �� �����صμ���.
pause
goto Extras

:System_Backup
cls
echo.
echo �ý��� ���� ������ ��� ���� ����մϴ�.
echo SDī�忡 ����� �� �����ʹ� ������� ������ ���� ����صμ���.
echo.
echo ������ �ؼ����� �� �ȳ���� "������ ���" ��ư�� �����ּ���.
echo ��ġ�� ���� �������� ���� �ɸ��ϴ�.
echo.
set file=%date%--%time:~0,2%-%time:~3,2%_systemBackup.ab
adb backup -f "..\%file%" -apk -noobb -noshared -all -system
if errorlevel 1 goto ERROR
start "" "explorer.exe" %~dp0
echo.
echo ����� �Ϸ�Ǿ����ϴ�.
echo %file% ������ �� �����صμ���.
pause
goto Extras

:Single_Backup
set package=
mode con cols=79 lines=1000
cls
echo.
echo  - ��Ű�� ��� -
echo.
adb shell pm list packages
echo.
echo ����Ϸ��� ���� ��Ű������ �Է� �� ����Ű�� ��������.
set /p package=
mode con cols=79 lines=39
if "%package%"=="" goto Backup
cls
echo.
echo Ư�� ���� ����մϴ�.
echo ����� �� : %package%
echo.
echo ������ �ؼ����� �� �ȳ���� "������ ���" ��ư�� �����ּ���.
echo.
set file=%date%--%time:~0,2%-%time:~3,2%_%package%_Backup.ab
adb backup -f "..\%file%" -apk %package%
if errorlevel 1 goto ERROR
start "" "explorer.exe" %~dp0
echo.
echo ����� �Ϸ�Ǿ����ϴ�.
echo %file% ������ �� �����صμ���.
pause
goto Extras

:Restore
set file=
cls
echo.
echo ����� ���� �ٽ� �����մϴ�.
echo.
echo ����! ���� ��ο� �ѱ۰� ���Ⱑ ���ԵǾ� ������ �� �˴ϴ�!
echo ����� ������ ���⿡ �巡�׾ص������ ������ ����Ű�� ��������.
set /p file=
if "%file%"=="" goto Extras
cls
echo.
echo ������ �ؼ����� �� �ȳ���� "������ ����" ��ư�� �����ּ���.
echo ���� ����� �� ��ȣ�� �����ϼ̴ٸ� ��ȣ �Է� �� ��ư�� �����ּ���.
echo ����� ���� �������� ���� �ɸ��ϴ�.
echo.
adb restore "%file%"
echo.
echo ������ �Ϸ�Ǿ����ϴ�.
pause
goto Extras

:Flash
set menu=
cls
echo.
echo                 ������������������������������������������������
echo                 ������������������������������������������������
echo                 ���� 1)     ��Ŀ����(Recovery) �÷���       ����
echo                 ������������������������������������������������
echo                 ������������������������������������������������
echo                 ���� 2)       ����(Radio) �÷���          ����
echo                 ������������������������������������������������
echo                 ������������������������������������������������
echo                 ���� 3)    ��Ʈ�δ�(Bootloader) �÷���      ����
echo                 ������������������������������������������������
echo                 ������������������������������������������������
echo                 ���� 4)         ��Ʈ(Boot) �÷���           ����
echo                 ������������������������������������������������
echo                 ������������������������������������������������
echo                 ���� 5)       �ý���(System) �÷���         ����
echo                 ������������������������������������������������
echo                 ������������������������������������������������
echo                 ���� 6)          zip ���� �÷���            ����
echo                 ������������������������������������������������
echo                 ������������������������������������������������
echo                 ���� B)              �ڷ�...                ����
echo                 ������������������������������������������������
echo                 ������������������������������������������������
echo.
set /p menu=���ϴ� ������ �Է� �� ����Ű�� �������� : 
if /i "%menu%"=="1" goto Recovery_Flash
if /i "%menu%"=="2" goto Radio_Flash
if /i "%menu%"=="3" goto Bootloader_Flash
if /i "%menu%"=="4" goto Boot_Flash
if /i "%menu%"=="5" goto System_Flash
if /i "%menu%"=="6" goto Sideload
if /i "%menu%"=="b" goto Extras
goto Flash

:Recovery_Flash
set file=
cls
echo.
echo ����! ���� ��ο� �ѱ۰� ���Ⱑ ���ԵǾ� ������ �� �˴ϴ�!
echo ��ġ�ϰ��� �ϴ� ��Ŀ���� img ������ ���⿡ �巡�׾ص������ ������ ����Ű�� ��������.
set /p file=
if "%file%"=="" goto Flash
goto Go_Recovery_Flash

:Go_Recovery_Flash
set menu=
cls
echo.
echo %file%
set /p menu=��Ŀ����(Recovery)�� ��ġ�մϴ�. ���� �����Ͻðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" (
cls
echo.
adb reboot bootloader
cls
echo.
ping -n 6 127.0.0.1 > nul
fastboot flash recovery "%file%"
if errorlevel 1 goto ERROR
echo.
echo ��Ŀ���� ��ġ�� �Ϸ�Ǿ����ϴ�.
pause
goto Flash
)
if /i "%menu%"=="n" goto Flash
goto Go_Recovery_Flash

:Radio_Flash
set file=
cls
echo.
echo ����! ���� ��ο� �ѱ۰� ���Ⱑ ���ԵǾ� ������ �� �˴ϴ�!
echo ��ġ�ϰ��� �ϴ� ���� img ������ ���⿡ �巡�׾ص������ ������ ����Ű�� ��������.
set /p file=
if "%file%"=="" goto Flash
goto Go_Radio_Flash

:Go_Radio_Flash
set menu=
cls
echo.
echo %file%
set /p menu=����(Radio)�� ��ġ�մϴ�. ���� �����Ͻðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" (
cls
echo.
adb reboot bootloader
cls
echo.
ping -n 6 127.0.0.1 > nul
fastboot flash radio "%file%"
if errorlevel 1 goto ERROR
echo.
echo ���� ��ġ�� �Ϸ�Ǿ����ϴ�.
pause
goto Flash
)
if /i "%menu%"=="n" goto Flash
goto Go_Radio_Flash

:Bootloader_Flash
set file=
cls
echo.
echo ����! ���� ��ο� �ѱ۰� ���Ⱑ ���ԵǾ� ������ �� �˴ϴ�!
echo ��ġ�ϰ��� �ϴ� ��Ʈ�δ� img ������ ���⿡ �巡�׾ص������ ������ ����Ű�� ��������.
set /p file=
if "%file%"=="" goto Flash
goto Go_Bootloader_Flash

:Go_Bootloader_Flash
set menu=
cls
echo.
echo %file%
set /p menu=��Ʈ�δ�(Bootloader)�� ��ġ�մϴ�. ���� �����Ͻðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" (
cls
echo.
adb reboot bootloader
cls
echo.
ping -n 6 127.0.0.1 > nul
fastboot flash bootloader "%file%"
if errorlevel 1 goto ERROR
echo.
echo ��Ʈ�δ� ��ġ�� �Ϸ�Ǿ����ϴ�.
pause
goto Flash
)
if /i "%menu%"=="n" goto Flash
goto Go_Bootloader_Flash

:Boot_Flash
set file=
cls
echo.
echo ����! ���� ��ο� �ѱ۰� ���Ⱑ ���ԵǾ� ������ �� �˴ϴ�!
echo ��ġ�ϰ��� �ϴ� ��Ʈ img ������ ���⿡ �巡�׾ص������ ������ ����Ű�� ��������.
set /p file=
if "%file%"=="" goto Flash
goto Go_Boot_Flash

:Go_Boot_Flash
set menu=
cls
echo.
echo %file%
set /p menu=��Ʈ(Boot)�� ��ġ�մϴ�. ���� �����Ͻðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" (
cls
echo.
adb reboot bootloader
cls
echo.
ping -n 6 127.0.0.1 > nul
fastboot flash boot "%file%"
if errorlevel 1 goto ERROR
echo.
echo ��Ʈ ��ġ�� �Ϸ�Ǿ����ϴ�.
pause
goto Flash
)
if /i "%menu%"=="n" goto Flash
goto Go_Boot_Flash

:System_Flash
set file=
cls
echo.
echo ����! ���� ��ο� �ѱ۰� ���Ⱑ ���ԵǾ� ������ �� �˴ϴ�!
echo ��ġ�ϰ��� �ϴ� �ý��� img ������ ���⿡ �巡�׾ص������ ������ ����Ű�� ��������.
set /p file=
if "%file%"=="" goto Flash
goto Go_System_Flash

:Go_System_Flash
set menu=
cls
echo.
echo %file%
set /p menu=�ý���(System)�� ��ġ�մϴ�. ���� �����Ͻðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" (
cls
echo.
adb reboot bootloader
cls
echo.
ping -n 6 127.0.0.1 > nul
fastboot flash system "%file%"
if errorlevel 1 goto ERROR
echo.
echo �ý��� ��ġ�� �Ϸ�Ǿ����ϴ�.
pause
goto Flash
)
if /i "%menu%"=="n" goto Flash
goto Go_System_Flash

:Sideload
set file=
cls
echo.
echo ����! ���� ��ο� �ѱ۰� ���Ⱑ ���ԵǾ� ������ �� �˴ϴ�!
echo �÷����ϰ��� �ϴ� zip ������ ���⿡ �巡�׾ص������ ������ ����Ű�� ��������.
set /p file=
if "%file%"=="" goto Flash
goto Go_Sideload

:Go_Sideload
set menu=
cls
echo.
echo %file%
set /p menu=zip ������ �÷����մϴ�. ���� �����Ͻðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" (
cls
echo.
echo ��Ŀ������ �������ּ���. �׸���
echo TWRP��� Advanced��ADB Sideload �޴��� ���� �����̴��� �о��ּ���.
echo CWM��� install zip from sideload �޴��� �� �ּ���.
pause
cls
echo.
adb sideload "%file%"
if errorlevel 1 goto ERROR
echo.
echo ���� ������ �Ϸ�Ǿ����ϴ�. �ڵ����� �÷����մϴ�.
echo �÷��̵� ������ /sdcard/sideload.zip���� ����˴ϴ�.
pause
goto Flash
)
if /i "%menu%"=="n" goto Flash
goto Go_Sideload

:Busybox
set menu=
cls
echo.
echo                 ������������������������������������������������
echo                 ������������������������������������������������
echo                 ���� I)           �����ڽ� ��ġ             ����
echo                 ������������������������������������������������
echo                 ������������������������������������������������
echo                 ���� U)           �����ڽ� ����             ����
echo                 ������������������������������������������������
echo                 ������������������������������������������������
echo                 ���� B)              �ڷ�...                ����
echo                 ������������������������������������������������
echo                 ������������������������������������������������
echo.
set /p menu=���ϴ� ������ �Է� �� ����Ű�� �������� : 
if /i "%menu%"=="i" goto Busybox_Installation
if /i "%menu%"=="u" goto Busybox_Uninstallation
if /i "%menu%"=="b" goto Extras
goto Busybox

:Busybox_Installation
set menu=
cls
echo.
set /p menu=�����ڽ�(Busybox)�� ��ġ�մϴ�. ���� �����Ͻðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" (
cls
echo.
adb reboot bootloader
cls
echo.
ping -n 6 127.0.0.1 > nul
fastboot boot %boot_recovery%
echo.
echo ��Ʈ������ ���� ���� ��Ŀ������ ���õ˴ϴ�.
echo ��ø� ��ٷ��ּ���.
if errorlevel 1 goto ERROR
ping -n 31 127.0.0.1 > nul
cls
echo.
echo ��Ʈ���� ȹ�� �� ��Ƽ�� ����Ʈ ��...
adb root
adb remount
adb shell mount /system
echo ���� ���� ��...
adb push busybox1221 /system/xbin/busybox
echo �۹̼� ���� ��...
adb shell chmod 04755 /system/xbin/busybox
echo �����ڽ� ��ġ ��...
adb shell /system/xbin/busybox --install -s /system/xbin
echo ����� ��...
adb reboot
if errorlevel 1 goto ERROR
echo.
echo �����ڽ� ��ġ�� �Ϸ�Ǿ����ϴ�.
pause
goto Extras
)
if /i "%menu%"=="n" goto Extras
goto Busybox_Installation

:Busybox_Uninstallation
set menu=
cls
echo.
set /p menu=�����ڽ�(Busybox)�� �����մϴ�. ���� �����Ͻðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" (
cls
echo.
adb reboot bootloader
cls
echo.
ping -n 6 127.0.0.1 > nul
fastboot boot %boot_recovery%
echo.
echo ��Ʈ������ ���� ���� ��Ŀ������ ���õ˴ϴ�.
echo ��ø� ��ٷ��ּ���.
if errorlevel 1 goto ERROR
ping -n 31 127.0.0.1 > nul
cls
echo.
echo ��Ʈ���� ȹ�� �� ��Ƽ�� ����Ʈ ��...
adb root
adb remount
adb shell mount /system
echo �����ڽ� �������� ���� ��...
adb shell rm -rf /system/xbin/[
adb shell rm -rf /system/xbin/[[
adb shell rm -rf /system/xbin/adjtimex
adb shell rm -rf /system/xbin/arp
adb shell rm -rf /system/xbin/ash
adb shell rm -rf /system/xbin/awk
adb shell rm -rf /system/xbin/base64
adb shell rm -rf /system/xbin/basename
adb shell rm -rf /system/xbin/bbconfig
adb shell rm -rf /system/xbin/blkid
adb shell rm -rf /system/xbin/blockdev
adb shell rm -rf /system/xbin/brctl
adb shell rm -rf /system/xbin/bunzip2
adb shell rm -rf /system/xbin/bzcat
adb shell rm -rf /system/xbin/bzip2
adb shell rm -rf /system/xbin/cal
adb shell rm -rf /system/xbin/cat
adb shell rm -rf /system/xbin/catv
adb shell rm -rf /system/xbin/chattr
adb shell rm -rf /system/xbin/chgrp
adb shell rm -rf /system/xbin/chmod
adb shell rm -rf /system/xbin/chown
adb shell rm -rf /system/xbin/chroot
adb shell rm -rf /system/xbin/clear
adb shell rm -rf /system/xbin/cmp
adb shell rm -rf /system/xbin/comm
adb shell rm -rf /system/xbin/cp
adb shell rm -rf /system/xbin/cpio
adb shell rm -rf /system/xbin/crond
adb shell rm -rf /system/xbin/crontab
adb shell rm -rf /system/xbin/cut
adb shell rm -rf /system/xbin/date
adb shell rm -rf /system/xbin/dc
adb shell rm -rf /system/xbin/dd
adb shell rm -rf /system/xbin/depmod
adb shell rm -rf /system/xbin/devmem
adb shell rm -rf /system/xbin/df
adb shell rm -rf /system/xbin/diff
adb shell rm -rf /system/xbin/dirname
adb shell rm -rf /system/xbin/dmesg
adb shell rm -rf /system/xbin/dnsd
adb shell rm -rf /system/xbin/dos2unix
adb shell rm -rf /system/xbin/du
adb shell rm -rf /system/xbin/echo
adb shell rm -rf /system/xbin/ed
adb shell rm -rf /system/xbin/egrep
adb shell rm -rf /system/xbin/env
adb shell rm -rf /system/xbin/expand
adb shell rm -rf /system/xbin/expr
adb shell rm -rf /system/xbin/false
adb shell rm -rf /system/xbin/fbsplash
adb shell rm -rf /system/xbin/fdisk
adb shell rm -rf /system/xbin/fgrep
adb shell rm -rf /system/xbin/find
adb shell rm -rf /system/xbin/flash_lock
adb shell rm -rf /system/xbin/flash_unlock
adb shell rm -rf /system/xbin/flashcp
adb shell rm -rf /system/xbin/flock
adb shell rm -rf /system/xbin/fold
adb shell rm -rf /system/xbin/free
adb shell rm -rf /system/xbin/freeramdisk
adb shell rm -rf /system/xbin/fstrim
adb shell rm -rf /system/xbin/fsync
adb shell rm -rf /system/xbin/ftpget
adb shell rm -rf /system/xbin/ftpput
adb shell rm -rf /system/xbin/fuser
adb shell rm -rf /system/xbin/getopt
adb shell rm -rf /system/xbin/grep
adb shell rm -rf /system/xbin/groups
adb shell rm -rf /system/xbin/gunzip
adb shell rm -rf /system/xbin/gzip
adb shell rm -rf /system/xbin/halt
adb shell rm -rf /system/xbin/head
adb shell rm -rf /system/xbin/hexdump
adb shell rm -rf /system/xbin/id
adb shell rm -rf /system/xbin/ifconfig
adb shell rm -rf /system/xbin/inetd
adb shell rm -rf /system/xbin/insmod
adb shell rm -rf /system/xbin/install
adb shell rm -rf /system/xbin/ionice
adb shell rm -rf /system/xbin/iostat
adb shell rm -rf /system/xbin/ip
adb shell rm -rf /system/xbin/kill
adb shell rm -rf /system/xbin/killall
adb shell rm -rf /system/xbin/killall5
adb shell rm -rf /system/xbin/less
adb shell rm -rf /system/xbin/ln
adb shell rm -rf /system/xbin/losetup
adb shell rm -rf /system/xbin/ls
adb shell rm -rf /system/xbin/lsattr
adb shell rm -rf /system/xbin/lsmod
adb shell rm -rf /system/xbin/lsusb
adb shell rm -rf /system/xbin/lzcat
adb shell rm -rf /system/xbin/lzma
adb shell rm -rf /system/xbin/lzop
adb shell rm -rf /system/xbin/lzopcat
adb shell rm -rf /system/xbin/man
adb shell rm -rf /system/xbin/md5sum
adb shell rm -rf /system/xbin/mesg
adb shell rm -rf /system/xbin/mkdir
adb shell rm -rf /system/xbin/mke2fs
adb shell rm -rf /system/xbin/mkfifo
adb shell rm -rf /system/xbin/mkfs.ext2
adb shell rm -rf /system/xbin/mkfs.vfat
adb shell rm -rf /system/xbin/mknod
adb shell rm -rf /system/xbin/mkswap
adb shell rm -rf /system/xbin/mktemp
adb shell rm -rf /system/xbin/modinfo
adb shell rm -rf /system/xbin/modprobe
adb shell rm -rf /system/xbin/more
adb shell rm -rf /system/xbin/mount
adb shell rm -rf /system/xbin/mountpoint
adb shell rm -rf /system/xbin/mpstat
adb shell rm -rf /system/xbin/mv
adb shell rm -rf /system/xbin/nanddump
adb shell rm -rf /system/xbin/nandwrite
adb shell rm -rf /system/xbin/nbd-client
adb shell rm -rf /system/xbin/netstat
adb shell rm -rf /system/xbin/nice
adb shell rm -rf /system/xbin/nohup
adb shell rm -rf /system/xbin/nslookup
adb shell rm -rf /system/xbin/ntpd
adb shell rm -rf /system/xbin/od
adb shell rm -rf /system/xbin/patch
adb shell rm -rf /system/xbin/pgrep
adb shell rm -rf /system/xbin/pidof
adb shell rm -rf /system/xbin/ping
adb shell rm -rf /system/xbin/pipe_progress
adb shell rm -rf /system/xbin/pkill
adb shell rm -rf /system/xbin/pmap
adb shell rm -rf /system/xbin/poweroff
adb shell rm -rf /system/xbin/printenv
adb shell rm -rf /system/xbin/printf
adb shell rm -rf /system/xbin/ps
adb shell rm -rf /system/xbin/pstree
adb shell rm -rf /system/xbin/pwd
adb shell rm -rf /system/xbin/pwdx
adb shell rm -rf /system/xbin/rdev
adb shell rm -rf /system/xbin/readlink
adb shell rm -rf /system/xbin/realpath
adb shell rm -rf /system/xbin/renice
adb shell rm -rf /system/xbin/reset
adb shell rm -rf /system/xbin/resize
adb shell rm -rf /system/xbin/rev
adb shell rm -rf /system/xbin/rm
adb shell rm -rf /system/xbin/rmdir
adb shell rm -rf /system/xbin/rmmod
adb shell rm -rf /system/xbin/route
adb shell rm -rf /system/xbin/run-parts
adb shell rm -rf /system/xbin/rx
adb shell rm -rf /system/xbin/sed
adb shell rm -rf /system/xbin/seq
adb shell rm -rf /system/xbin/setconsole
adb shell rm -rf /system/xbin/setserial
adb shell rm -rf /system/xbin/setsid
adb shell rm -rf /system/xbin/sh
adb shell rm -rf /system/xbin/sha1sum
adb shell rm -rf /system/xbin/sha256sum
adb shell rm -rf /system/xbin/sha3sum
adb shell rm -rf /system/xbin/sha512sum
adb shell rm -rf /system/xbin/sleep
adb shell rm -rf /system/xbin/sort
adb shell rm -rf /system/xbin/split
adb shell rm -rf /system/xbin/stat
adb shell rm -rf /system/xbin/strings
adb shell rm -rf /system/xbin/stty
adb shell rm -rf /system/xbin/sum
adb shell rm -rf /system/xbin/swapoff
adb shell rm -rf /system/xbin/swapon
adb shell rm -rf /system/xbin/sync
adb shell rm -rf /system/xbin/sysctl
adb shell rm -rf /system/xbin/tac
adb shell rm -rf /system/xbin/tail
adb shell rm -rf /system/xbin/tar
adb shell rm -rf /system/xbin/taskset
adb shell rm -rf /system/xbin/tee
adb shell rm -rf /system/xbin/telnet
adb shell rm -rf /system/xbin/telnetd
adb shell rm -rf /system/xbin/test
adb shell rm -rf /system/xbin/tftp
adb shell rm -rf /system/xbin/tftpd
adb shell rm -rf /system/xbin/time
adb shell rm -rf /system/xbin/timeout
adb shell rm -rf /system/xbin/top
adb shell rm -rf /system/xbin/touch
adb shell rm -rf /system/xbin/tr
adb shell rm -rf /system/xbin/traceroute
adb shell rm -rf /system/xbin/true
adb shell rm -rf /system/xbin/ttysize
adb shell rm -rf /system/xbin/tune2fs
adb shell rm -rf /system/xbin/umount
adb shell rm -rf /system/xbin/uname
adb shell rm -rf /system/xbin/uncompress
adb shell rm -rf /system/xbin/unexpand
adb shell rm -rf /system/xbin/uniq
adb shell rm -rf /system/xbin/unix2dos
adb shell rm -rf /system/xbin/unlzma
adb shell rm -rf /system/xbin/unlzop
adb shell rm -rf /system/xbin/unpigz -> pigz
adb shell rm -rf /system/xbin/unxz
adb shell rm -rf /system/xbin/unzip
adb shell rm -rf /system/xbin/uptime
adb shell rm -rf /system/xbin/usleep
adb shell rm -rf /system/xbin/uudecode
adb shell rm -rf /system/xbin/uuencode
adb shell rm -rf /system/xbin/vi
adb shell rm -rf /system/xbin/watch
adb shell rm -rf /system/xbin/wc
adb shell rm -rf /system/xbin/wget
adb shell rm -rf /system/xbin/which
adb shell rm -rf /system/xbin/whoami
adb shell rm -rf /system/xbin/xargs
adb shell rm -rf /system/xbin/xz
adb shell rm -rf /system/xbin/xzcat
adb shell rm -rf /system/xbin/yes
adb shell rm -rf /system/xbin/zcat
adb shell rm -rf /system/bin/busybox
adb shell rm -rf /system/xbin/busybox
echo ����� ��...
adb reboot
if errorlevel 1 goto ERROR
echo.
echo �����ڽ� ������ �Ϸ�Ǿ����ϴ�.
pause
goto Extras
)
if /i "%menu%"=="n" goto Extras
goto Busybox_Uninstallation

:IMEI
set menu=
cls
echo.
echo                 ������������������������������������������������
echo                 ������������������������������������������������
echo                 ���� 1)             IMEI ���               ����
echo                 ������������������������������������������������
echo                 ������������������������������������������������
echo                 ���� 2)             IMEI ����               ����
echo                 ������������������������������������������������
echo                 ������������������������������������������������
echo                 ���� B)              �ڷ�...                ����
echo                 ������������������������������������������������
echo                 ������������������������������������������������
echo.
set /p menu=���ϴ� ������ �Է� �� ����Ű�� �������� : 
if /i "%menu%"=="1" goto IMEI_Backup
if /i "%menu%"=="2" goto IMEI_Restore
if /i "%menu%"=="b" goto Extras
goto IMEI

:IMEI_Backup
cls
echo.
adb reboot bootloader
cls
echo.
ping -n 6 127.0.0.1 > nul
fastboot boot %boot_recovery%
echo.
echo ��Ʈ������ ���� ���� ��Ŀ������ ���õ˴ϴ�.
echo ��ø� ��ٷ��ּ���.
if errorlevel 1 goto ERROR
ping -n 31 127.0.0.1 > nul
cls
echo.
echo ��Ʈ���� ȹ�� �� ��Ƽ�� ����Ʈ ��...
adb root
adb remount
adb shell mount /system
adb shell mount /efs
echo efs ��� ��...
adb shell dd if=/dev/block/platform/omap/omap_hsmmc.0/by-name/efs of=/sdcard/efs_backup.img
echo efs ��� ���� ������ ��...
adb pull "/sdcard/efs_backup.img" ".."
echo efs ��� ���� ���� ��...
adb shell rm -r /sdcard/efs_backup.img
echo ����� ��...
adb reboot
if errorlevel 1 goto ERROR
start "" "explorer.exe" %~dp0
echo.
echo IMEI ����� �Ϸ�Ǿ����ϴ�.
echo efs_backup.img ������ �� �����صμ���.
pause
goto Extras

:IMEI_Restore
set menu=
cls
echo.
set /p menu=IMEI�� �����մϴ�. ���� �����Ͻðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" goto Go_IMEI_Restore
if /i "%menu%"=="n" goto IMEI
goto IMEI_Restore

:Go_IMEI_Restore
set file=
cls
echo.
echo ����! ���� ��ο� �ѱ۰� ���Ⱑ ���ԵǾ� ������ �� �˴ϴ�!
echo ����� ������ ���⿡ �巡�׾ص������ ������ ����Ű�� ��������.
set /p file=
if "%file%"=="" goto Extras
cls
echo.
adb reboot bootloader
cls
echo.
ping -n 6 127.0.0.1 > nul
fastboot boot %boot_recovery%
echo.
echo ��Ʈ������ ���� ���� ��Ŀ������ ���õ˴ϴ�.
echo ��ø� ��ٷ��ּ���.
if errorlevel 1 goto ERROR
ping -n 31 127.0.0.1 > nul
cls
echo.
echo ��Ʈ���� ȹ�� �� ��Ƽ�� ����Ʈ ��...
adb root
adb remount
adb shell mount /system
adb shell mount /efs
echo efs ��� ���� �޴� ��...
adb push "%file%" /sdcard/efs_backup.img
echo efs ���� ��...
adb shell dd if=/sdcard/efs_backup.img of=/dev/block/platform/omap/omap_hsmmc.0/by-name/efs
echo efs ��� ���� ���� ��...
adb shell rm -r /sdcard/efs_backup.img
echo ����� ��...
adb reboot
if errorlevel 1 goto ERROR
echo.
echo IMEI ������ �Ϸ�Ǿ����ϴ�.
pause
goto Extras

:Password
set menu=
cls
echo.
set /p menu=�ȵ���̵� ��ȣ�� �����մϴ�. ���� �����Ͻðڽ��ϱ�? (Y/N) : 
if /i "%menu%"=="y" (
cls
echo.
adb reboot bootloader
cls
echo.
ping -n 6 127.0.0.1 > nul
fastboot boot %boot_recovery%
echo.
echo ��Ʈ������ ���� ���� ��Ŀ������ ���õ˴ϴ�.
echo ��ø� ��ٷ��ּ���.
if errorlevel 1 goto ERROR
ping -n 31 127.0.0.1 > nul
cls
echo.
echo ��Ʈ���� ȹ�� �� ��Ƽ�� ����Ʈ ��...
adb root
adb remount
adb shell mount /data
echo ��ȣ ���� ���� ��...
adb shell rm -rf /data/system/gesture.key
adb shell rm -rf /data/system/password.key
echo ����� ��...
adb reboot
if errorlevel 1 goto ERROR
echo.
echo �ȵ���̵� ��ȣ ������ �Ϸ�Ǿ����ϴ�.
pause
goto Extras
)
if /i "%menu%"=="n" goto Extras
goto Password

:ERROR
echo.
echo ������ �߻��Ͽ����ϴ�.
pause
goto Main
