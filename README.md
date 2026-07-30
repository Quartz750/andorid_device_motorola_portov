# andorid_device_motorola_portov

## notice

If you wanna extract vendor blobs for portov:

- connect to portov

```bash
adb shell su -c "setenforce 0"
chmod +x extract-files.py
./extract-files.py
```