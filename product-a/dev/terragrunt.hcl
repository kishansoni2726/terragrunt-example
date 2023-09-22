terraform {
    source = "../../infrastructure-modules"
}

include "root" {
    path = find_in_parent_folders()
}
