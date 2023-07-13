lw x4, 0(x4)          # Load memory address = [x4 + 0(Offset)] 's value in register x4
lw x5, 4(x5)          # Load memory address = [x5 + 4(Offset)] 's value in register x5
add x6, x5, x4        # Add x5 and x4 register values and store it into x6 register
sw x6, 8(x0)          # store register x6's value in memory address = [x0 + 8(Offset)]