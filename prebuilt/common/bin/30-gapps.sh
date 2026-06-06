#!/sbin/sh
#
# ADDOND_VERSION=3
#
# /system/addon.d/30-gapps.sh
#
. /tmp/backuptool.functions
list_files() {
cat <<FILELIST
system_ext/etc/permissions/privapp-permissions-google-system-ext.xml
system_ext/priv-app/GoogleServicesFramework/GoogleServicesFramework.apk
system_ext/priv-app/GoogleFeedback/GoogleFeedback.apk
product/lib64/libjni_latinimegoogle.so
product/framework/com.google.android.dialer.support.jar
product/priv-app/GooglePartnerSetup/GooglePartnerSetup.apk
product/priv-app/AndroidAutoStub/AndroidAutoStub.apk
product/priv-app/GmsCore/GmsCore.apk
product/priv-app/Phonesky/Phonesky.apk
product/overlay/GmsSettingsOverlay.apk
product/overlay/GmsSetupWizardOverlay.apk
product/overlay/GmsSettingsProviderOverlay.apk
product/overlay/GmsOverlay.apk
product/app/PrebuiltExchange3Google/PrebuiltExchange3Google.apk
product/app/GoogleCalendarSyncAdapter/GoogleCalendarSyncAdapter.apk
product/app/GoogleContactsSyncAdapter/GoogleContactsSyncAdapter.apk
product/etc/security/fsverity/gms_fsverity_cert.der
product/etc/init/gapps.rc
product/etc/default-permissions/default-permissions-mtg.xml
product/etc/default-permissions/default-permissions-google.xml
product/etc/sysconfig/sysconfig_contextual_search.xml
product/etc/sysconfig/google-hiddenapi-package-allowlist.xml
product/etc/sysconfig/google.xml
product/etc/sysconfig/d2d_cable_migration_feature.xml
product/etc/sysconfig/wellbeing.xml
product/etc/sysconfig/google_build.xml
product/etc/permissions/privapp-permissions-mtg.xml
product/etc/permissions/com.google.android.dialer.support.xml
product/etc/permissions/privapp-permissions-google-product.xml
FILELIST
}
case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file $S/$FILE
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/$FILE $R
    done
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Stub
  ;;
  post-restore)
    for i in $(list_files); do
      f=$(get_output_path "$S/$i")
      chown root:root $f
      chmod 644 $f
      chmod 755 $(dirname $f)
    done
  ;;
esac
