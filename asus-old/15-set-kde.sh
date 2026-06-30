kwriteconfig6 --file powerdevilrc --group AC --group Display --key DimDisplayIdleTimeoutSec -- -1 && \
kwriteconfig6 --file powerdevilrc --group AC --group Display --key DimDisplayWhenIdle false && \
kwriteconfig6 --file powerdevilrc --group AC --group Display --key TurnOffDisplayIdleTimeoutSec -- -1 && \
kwriteconfig6 --file powerdevilrc --group AC --group Display --key TurnOffDisplayWhenIdle false && \
kwriteconfig6 --file powerdevilrc --group AC --group SuspendAndShutdown --key AutoSuspendAction 0 && \
kwriteconfig6 --file powerdevilrc --group AC --group SuspendAndShutdown --key LidAction 0 && \
kwriteconfig6 --file powerdevilrc --group AC --group SuspendAndShutdown --key PowerButtonAction 0 && \
kwriteconfig6 --file powerdevilrc --group Battery --group Display --key DimDisplayIdleTimeoutSec -- -1 && \
kwriteconfig6 --file powerdevilrc --group Battery --group Display --key DimDisplayWhenIdle false && \
kwriteconfig6 --file powerdevilrc --group Battery --group Display --key TurnOffDisplayIdleTimeoutSec -- -1 && \
kwriteconfig6 --file powerdevilrc --group Battery --group Display --key TurnOffDisplayWhenIdle false && \
kwriteconfig6 --file powerdevilrc --group Battery --group SuspendAndShutdown --key AutoSuspendAction 0 && \
kwriteconfig6 --file powerdevilrc --group Battery --group SuspendAndShutdown --key LidAction 0 && \
kwriteconfig6 --file powerdevilrc --group Battery --group SuspendAndShutdown --key PowerButtonAction 0 && \
kwriteconfig6 --file powerdevilrc --group BatteryManagement --key BatteryCriticalAction 0 && \
kwriteconfig6 --file powerdevilrc --group LowBattery --group Display --key DimDisplayIdleTimeoutSec -- -1 && \
kwriteconfig6 --file powerdevilrc --group LowBattery --group Display --key DimDisplayWhenIdle false && \
kwriteconfig6 --file powerdevilrc --group LowBattery --group Display --key TurnOffDisplayIdleTimeoutSec -- -1 && \
kwriteconfig6 --file powerdevilrc --group LowBattery --group Display --key TurnOffDisplayWhenIdle false && \
kwriteconfig6 --file powerdevilrc --group LowBattery --group Display --key UseProfileSpecificDisplayBrightness false && \
kwriteconfig6 --file powerdevilrc --group LowBattery --group SuspendAndShutdown --key AutoSuspendAction 0 && \
kwriteconfig6 --file powerdevilrc --group LowBattery --group SuspendAndShutdown --key LidAction 0 && \
kwriteconfig6 --file powerdevilrc --group LowBattery --group SuspendAndShutdown --key PowerButtonAction 0 && \
kwriteconfig6 --file kscreenlockerrc --group Daemon --key Autolock false && \
kwriteconfig6 --file kscreenlockerrc --group Daemon --key LockGrace 0 && \
kwriteconfig6 --file kscreenlockerrc --group Daemon --key Timeout 0 && \
kwriteconfig6 --file systemsettingsrc --group systemsettings_sidebar_mode --key HighlightNonDefaultSettings true && \
plasma-apply-lookandfeel --apply org.kde.breezedark.desktop && \
echo "===== SUCCESS, RUN [reboot], FINISHED ====="
