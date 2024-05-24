% Функција која ја интегрираме
f = @(x) x .* sin(x);

% Аналитичко решение
I_exact = pi;

% Број на подинтервали
n_values = [10, 20, 50, 200];

% Листа за чување на грешките
errors_S = [];
errors_T = [];
errors_R = [];

% Пресметување на грешките за секој број на подинтервали
for n = n_values
    x = linspace(0, pi, n+1);
    y = f(x);
    
    % Симпсоново правило
    S = simpsons_rule(x, y);
    
    % Трапезно правило
    T = trapz(x, y);
    
    % Правоаголно правило (средна точка)
    h = (pi - 0) / n;
    x_mid = linspace(h/2, pi-h/2, n);
    R = h * sum(f(x_mid));
    
    % Пресметување на релативните грешки
    e_S = abs((S - I_exact) / I_exact);
    e_T = abs((T - I_exact) / I_exact);
    e_R = abs((R - I_exact) / I_exact);
    
    errors_S = [errors_S, e_S];
    errors_T = [errors_T, e_T];
    errors_R = [errors_R, e_R];
end

% Графичко претставување
figure;
loglog(n_values, errors_S, 'o-', 'DisplayName', 'Симпсоново правило');
hold on;
loglog(n_values, errors_T, 's-', 'DisplayName', 'Трапезно правило');
loglog(n_values, errors_R, 'd-', 'DisplayName', 'Правоаголно правило (средна точка)');
xlabel('Број на подинтервали');
ylabel('Релативна грешка');
title('Релативни грешки на различни правила за нумеричка интеграција');
legend;
grid on;
hold off;

% Симпсоново правило функција
function S = simpsons_rule(x, y)
    n = length(x) - 1;
    h = (x(end) - x(1)) / n;
    S = (h/3) * (y(1) + 2*sum(y(3:2:n)) + 4*sum(y(2:2:n)) + y(end));
end
