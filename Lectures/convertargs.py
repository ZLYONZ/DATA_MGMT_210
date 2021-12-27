import sys

def tempconvert(temp, dir = 'f2c'):
    
    try:
        if dir == 'f2c':
            f = float(temp)
            c = (f - 32) / 9 * 5
            return c
        elif dir == 'c2f':
            c = float(temp)
            f = c * 9/5 + 32
            return f
        else: 
            print(f'You must pick, you pick{dir}')
    except ValueError:
        print(f'Temperature must be real number, you gave {temp}')
        
def main():
    args = len(sys.argv)
    
    if args == 1 or args > 3:
        print(f'usage {sys.argv[0]} temperture ["f2c"|"c2f"]')
        return 
    
    if args == 2:
        res = tempconvert(float(sys.argv[1]))
    else:
        res = tempconvert(float(sys.argv[1]), sys.argv[2])
        
    print(res)
    
main()

