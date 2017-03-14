// 1
function u = suite(n)
    u = cos(n) ./ n
endfunction

//x=1:20
//plot(x, suite(x))

// la suite est bornée entre -0.4 et 0.6
// la suite n'est pas monotone
// la suite tend vers 0 quand n tend vers l'infini

// 2
function u = rec(n, u0, f)
    u = u0
    for i = 1 : n - 1
        u = [u f(u(i))]
    end
endfunction

//deff('y=f(x)', 'y=(x+2)/(5-2*x)')
//plot(x, rec(20, 0, f))
//
//deff('y=f(x)', 'y=sqrt(2-x)')
//plot(x, rec(20, 0, f))

// la suite est bornée entre 0 et 1.6
// la suite n'est pas monotone
// la suite tend vers 1 quand vers n tend vers l'infini

// 3
function u = recursiv_graph(u0, f, n)
    x = -1:.01:7;
    plot(x, f(x), '-b');
    plot(x,x);
    
    //x = [u0 u0 u1 u1 u2]
    //y = [ 0 u1 u1 u2 u2]
    s = rec(n, u0, f)
    x = [s(1) s(1)]
    y = [0 s(2)]
    for i = 2 : n - 1
        x = [x s(i) s(i)]
        y = [y s(i) s(i+1)]
    end
    plot(x, y, 'r')
endfunction

deff('y=f(x)', 'y=((x+1).*(9-x)) ./ 4')
recursiv_graph(-1/2, f, 20)

// 4
deff('y=f(x)', 'y=1 ./ (1+(x.^2))')
deff('y=f(x)', 'y=sqrt(5+x)')
deff('y=f(x)', 'y=(x+1) ./ (2.*x)')
deff('y=f(x)', 'y=-1/15.*(x.^3)-2/15.*(x.^2)+2.*x')
