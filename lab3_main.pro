domains
    pharmacyID = string.
    pharmacyName = string.
    address = string.
    phone = string.
    medID = string.
    medication = string.
    price = real.
    quantity = integer.

predicates
    run : string -> string.

clauses
    % Загрузка базы фактов из файла
    run(FileName) :-
        consult(FileName),
        write("База фактов загружена."), nl,
        main_menu.

    % Главное меню
    main_menu :-
        write("1. Найти аптеку, где лекарство самое дешевое."), nl,
        write("2. Проверить наличие лекарства в определенной аптеке."), nl,
        write("3. Вычислить среднюю цену заданного лекарства."), nl,
        write("4. Выход."), nl,
        write("Введите номер команды: "),
        read(Command),
        process_command(Command).

    % Обработка команды
    process_command(1) :-
        write("Введите название лекарства: "),
        read(Medication),
        write("Введите количество: "),
        read(Quantity),
        findall([Medication, Price, Pharmacy, Address], cheapest_pharmacy(Medication, Quantity, Pharmacy, Address, Price), Result),
        print_list(Result),
        main_menu.

    process_command(2) :-
        write("Введите название лекарства: "),
        read(Medication),
        write("Введите код аптеки: "),
        read(PharmacyID),
        findall([Medication, Price, Quantity], available_at(Medication, PharmacyID, Price, Quantity), Result),
        print_list(Result),
        main_menu.

    process_command(3) :-
        write("Введите название лекарства: "),
        read(Medication),
        findall(Price, available_at(Medication, _, Price, _), Prices),
        calculate_average(Prices, AveragePrice),
        write("Средняя цена для лекарства "),
        write(Medication),
        write(" составляет "),
        write(AveragePrice),
        write("."), nl,
        main_menu.

    process_command(4) :-
        write("Выход из программы."), nl.

    process_command(_) :-
        write("Некорректная команда."), nl,
        main_menu.

    % Правило для проверки наличия лекарства в аптеке
    available_at(Medication, PharmacyID, Price, Quantity) :-
        medication(MedID, Medication),
        pharmacy(PharmacyID, _, _, _),
        sales(PharmacyID, MedID, Price, Quantity).

    % Правило для поиска самой дешевой аптеки, где доступно лекарство
    cheapest_pharmacy(Medication, Quantity, PharmacyID, Address, Price) :-
        available_at(Medication, PharmacyID, Price, Quantity),
        not((available_at(Medication, OtherPharmacy, OtherPrice, _), OtherPrice < Price)),
        pharmacy(PharmacyID, _, Address, _).

    % Правило для вывода элементов списка
    print_list([]).
    print_list([[Medication, Price, Pharmacy, Address] | Rest]) :-
        write("Лекарство: "), write(Medication),
        write(", Цена: "), write(Price),
        write(", Аптека: "), write(Pharmacy),
        write(", Адрес: "), write(Address),
        nl,
        print_list(Rest).

    % Правило для вычисления среднего значения списка
    calculate_average(List, Average) :-
        sum_list(List, Sum),
        length(List, Length),
        Average is Sum / Length.
