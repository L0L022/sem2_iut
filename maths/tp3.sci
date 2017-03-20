//ex1

deff('y=f(x)', 'y=x.^3-3.*x.^2+2.*x+5')
x = -1:.01:1;
plot(x, f(x), '-b');
plot(x, 0.*x, '-r')

//solution est -0.9; l'intervalle est [-1; 0]

//ex2

function sol = newton1(x0, n)
    deff('y=f(x)', 'y=x.^3-3.*x.^2+2.*x+5')
    deff('y=g(x)', 'y=3.*x.^2-6.*x+2')
    x = x0
    for i = 1 : n
        x = x - f(x)/g(x)
    end
    sol = x
endfunction

disp(newton1(2, 6), "newton1") //- 0.9041609

//ex3
function sol = newton2(x0, eps)
    deff('y=f(x)', 'y=x.^3-3.*x.^2+2.*x+5')
    deff('y=g(x)', 'y=3.*x.^2-6.*x+2')
    i = 0
    w = x0 + eps + 1
    x = x0
    while(abs(x - w) > eps)
        i = i + 1
        w = x
        x = x - f(x)/g(x)
    end
    disp(i, "nombre d’itérations nécessaires")
    sol = x
endfunction

disp("newton2")
disp(newton2(2, 10^-8), "resultat") //- 0.9041609 ; 6 itérations

//ex4

function sol = newton3(f, x0, eps)
    h = eps
    deff('y=g(x)', 'y=(f(x+h)-f(x)) ./ h')
    i = 0
    w = x0 + eps + 1
    x = x0
    while(abs(x - w) > eps)
        w = x
        x = x - f(x)/g(x)
    end
    sol = x
endfunction

deff('y=f(x)', 'y=x.^3-3.*x.^2+2.*x+5')
disp(newton3(f, 2, 10^-8), "newton3 - 1") //- 0.9041609
deff('y=f(x)', 'y=cos(x)-x.^2')
disp(newton3(f, 2, 10^-8), "newton3 - 2") //0.8241323

//ex5

function sol = dichotomie(f, a, b, eps)
    i = 0
    while(abs(b - a) > eps)
        i = i + 1
        c = (a + b)/2
        if(f(a) * f(c) < 0)
            b = c
        else
            a = c
        end
    end
    disp(i, "nombre d’itérations nécessaires")
    sol = c
endfunction

deff('y=f(x)', 'y=x.^3-3.*x.^2+2.*x+5')
disp("dichotomie - 1")
disp(dichotomie(f, -1, 0, 10^-8), "resultat") //- 0.9041609 ; 27 itérations
deff('y=f(x)', 'y=cos(x)-x.^2')
disp("dichotomie - 2")
disp(dichotomie(f, 0, 1, 10^-8), "resultat") // 0.8241323 ; 27 itérations
