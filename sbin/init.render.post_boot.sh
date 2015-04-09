#!/system/bin/sh

BB=/sbin/bb/busybox

############################
# Custom Kernel Settings for Render Kernel!!
#
stop mpdecision
echo "[Render-Kernel] Boot Script Started" | tee /dev/kmsg

############################
# MSM_Hotplug Settings
#
echo 2 > /sys/module/msm_hotplug/min_cpus_online
echo 1 > /sys/module/msm_hotplug/cpus_boosted
echo 500 > /sys/module/msm_hotplug/down_lock_duration
echo 2500 > /sys/module/msm_hotplug/boost_lock_duration
echo 200 5:100 50:50 350:200 > /sys/module/msm_hotplug/update_rates
echo 100 > /sys/module/msm_hotplug/fast_lane_load
echo 1 > /sys/module/msm_hotplug/max_cpus_online_susp

############################
# CPU-Boost Settings
#
echo 20 > /sys/module/cpu_boost/parameters/boost_ms
echo 60 > /sys/module/cpu_boost/parameters/input_boost_ms
echo 0:1190400 1:1190400 2:1190400 3:1190400 > /sys/module/cpu_boost/parameters/input_boost_freq
echo 1420800 > /sys/module/cpu_boost/parameters/sync_threshold
echo 1 > /sys/module/cpu_boost/parameters/hotplug_boost
echo 1 > /sys/module/cpu_boost/parameters/wakeup_boost

############################
# Tweak Background Writeout
#
echo 200 > /proc/sys/vm/dirty_expire_centisecs
echo 40 > /proc/sys/vm/dirty_ratio
echo 5 > /proc/sys/vm/dirty_background_ratio
echo 10 > /proc/sys/vm/swappiness

############################
# ZRAM Settings
#
#echo "lzo [lz4]" > /sys/block/zram0/comp_algorithm
#echo 3 > /sys/block/zram0/max_comp_stream
#echo 300 > /sys/devices/virtual/block/zram0/disksize

############################
# Power Effecient Workqueues (Enable for battery)
#
echo 1 > /sys/module/workqueue/parameters/power_efficient

############################
# MSM Limiter
#
echo 146400 > /sys/kernel/msm_limiter/suspend_min_freq_0
echo 146400 > /sys/kernel/msm_limiter/suspend_min_freq_1
echo 146400 > /sys/kernel/msm_limiter/suspend_min_freq_2
echo 146400 > /sys/kernel/msm_limiter/suspend_min_freq_3
echo 2726400 > /sys/kernel/msm_limiter/resume_max_freq_0
echo 2726400 > /sys/kernel/msm_limiter/resume_max_freq_1
echo 2726400 > /sys/kernel/msm_limiter/resume_max_freq_2
echo 2726400 > /sys/kernel/msm_limiter/resume_max_freq_3
echo 1267200 > /sys/kernel/msm_limiter/suspend_max_freq

############################
# Scheduler and Read Ahead
#
echo zen > /sys/block/mmcblk0/queue/scheduler
echo 1024 > /sys/block/mmcblk0/bdi/read_ahead_kb

############################
# GPU Governor
#
echo 578000000 > /sys/devices/fdb00000.qcom,kgsl-3d0/devfreq/fdb00000.qcom,kgsl-3d0/max_freq

############################
# LMK Tweaks
#
echo 2560,4096,8192,16384,24576,32768 > /sys/module/lowmemorykiller/parameters/minfree
echo 32 > /sys/module/lowmemorykiller/parameters/cost

############################
# Disable Debugging
#
echo "0" > /sys/module/kernel/parameters/initcall_debug;
echo "0" > /sys/module/alarm_dev/parameters/debug_mask;
echo "0" > /sys/module/binder/parameters/debug_mask;
echo "0" > /sys/module/xt_qtaguid/parameters/debug_mask;
echo "[Render-Kernel] disable debug mask" | tee /dev/kmsg

############################
# KCAL Tunings Thanks AK!
#
echo "256 256 256" > /sys/devices/platform/kcal_ctrl.0/kcal
echo "35" > /sys/devices/platform/kcal_ctrl.0/kcal_min
echo "1" > /sys/devices/platform/kcal_ctrl.0/kcal_enable
echo "0" > /sys/devices/platform/kcal_ctrl.0/kcal_invert
echo "275" > /sys/devices/platform/kcal_ctrl.0/kcal_sat
echo "0" > /sys/devices/platform/kcal_ctrl.0/kcal_hue
echo "251" > /sys/devices/platform/kcal_ctrl.0/kcal_val
echo "258" > /sys/devices/platform/kcal_ctrl.0/kcal_cont
echo "[Render-Kernel] kcal sgs amoled settings done" | tee /dev/kmsg

echo "[Render-Kernel] Boot Script Completed!" | tee /dev/kmsg
