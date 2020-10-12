DTB_PART=mtd0
DTB=mtd0
RESCUE_PART=mtd2
RESCUE=mtd2

board_hook() {
    flash "Linux kernel for rescue system" mtd1 mtd1
    flash "Factory image" mtd3 mtd3
}
