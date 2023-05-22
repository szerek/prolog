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
        write("3. Выход."), nl,
        write("Введите номер команды: "),
        read(Command),
        process_command(Command).

    % Обработка команды
    process_command(1) :-
        write("Введите название лекарства: "),
        read(Medication),
        write("Введите количество: "),
        read(Quantity),
        cheapest_pharmacy(Medication, Quantity, Pharmacy, Address),
        write("Самое дешевое лекарство "), write(Medication),
        write(" доступно в аптеке "), write(Pharmacy),
        write(" по адресу "), write(Address), write("."), nl,
        main_menu.
        
    process_command(2) :-
        write("Введите название лекарства: "),
        read(Medication),
        write("Введите код аптеки: "),
        read(PharmacyID),
        available_at(Medication, PharmacyID, Price, Quantity),
        write("Лекарство "), write(Medication),
        write(" доступно в аптеке "), write(PharmacyID),
        write(" по цене "), write(Price),
        write(" с количеством "), write(Quantity), write("."), nl,
        main_menu.

    process_command(3) :-
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
    cheapest_pharmacy(Medication, Quantity, PharmacyID, Address) :-
        available_at(Medication, PharmacyID, Price, Quantity),
        not((available_at(Medication, OtherPharmacy, OtherPrice, _), OtherPrice < Price)),
        pharmacy(PharmacyID, _, Address, _).
