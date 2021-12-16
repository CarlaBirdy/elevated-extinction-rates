# Elevated extinction rate analysis
This folder contains the code for the elevated extinction rate analysis based on Ceballos et al. (2015), this analysis was led by Carla Archibald. This code takes data compilled on the described species (Chapman et al. 2009), extinctions numbers (Woinarski et al. 2019) and underlying extinction rates (Barnosky, et al. 2011; Humphreys, et al. 2019).

## Methid

To calculate the expected number of extinct species (ex) we used the following formula where n is equal to the number of described species, r is the background extinction rate (of 0.35 E/MSY or 2 E/MSY), and c is equal to the number of centuries since 1900 (you can also change this year to 1500).

ex = n /10000 * (r * c)

To calculate the estimated extinctions (EX) we used the following formula, where ex is equal to the expected number of extinct species (calculated above) and d the number of documented extinct species as established by Woinarski et al., (2019).

EX = ex / d

This is a simple method to calculate extinction risk that doesn’t consider processes such as speciation, extinction debt or co-extinctions. However, this method does provide an adequate estimate of what the modern-day extinction rates may be in Australia and can be used to inform policy and raise awareness to the extinction crisis in Australia. 


## Key references
Barnosky, A. et al. (2011) ‘Has the Earth’s sixth mass extinction already arrived?’, Nature. Nature Publishing Group, 471(7336), pp. 51–57. doi: 10.1038/nature09678.

Ceballos, G. et al. (2015) ‘Accelerated modern human-induced species losses: Entering the sixth mass extinction’, Science Advances, 1(5), pp. 9–13. doi: 10.1126/sciadv.1400253.

Chapman, A. et al. (2009) Numbers of Living Species in Australia and the World. Toowoomba, Australia: Biodiversity Information Services.

Humphreys, A. et al. (2019) ‘Global dataset shows geography and life form predict modern plant extinction and rediscovery’, Nature Ecology and Evolution. Springer US, 3(7), pp. 1043–1047. doi: 10.1038/s41559-019-0906-2.

Woinarski, J. et al. (2019) ‘Reading the black book: The number, timing, distribution and causes of listed extinctions in Australia’, Biological Conservation. Elsevier, 239(November), p. 108261. doi: 10.1016/j.biocon.2019.108261.
