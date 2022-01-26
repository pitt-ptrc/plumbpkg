library(plumber)

#* @apiTitle PULCE ID service API

#* Get the hash
#* @param id The ID for the hash
#* @get /hash
plumbpkg:::get_hash()

#* Get the dateshift
#* @param id The ID for the dateshift
#* @get /dateshift
plumbpkg:::get_shift()
