def calculer_vitesse_metres_par_seconde(vitesse_pixels_par_seconde, resolution_ecran_pixels_par_metre,
                                        taille_reelle_ballon_cm):
    rayon_ballon_metres = (taille_reelle_ballon_cm / 2) / 100
    vitesse_metres_par_seconde = (vitesse_pixels_par_seconde / resolution_ecran_pixels_par_metre) * (
            2 * rayon_ballon_metres)
    return vitesse_metres_par_seconde
