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
    % ���ѧԧ��٧ܧ� �ҧѧ٧� ��ѧܧ��� �ڧ� ��ѧۧݧ�
    run(FileName) :-
        consult(FileName),
        write("���ѧ٧� ��ѧܧ��� �٧ѧԧ��ا֧ߧ�."), nl,
        main_menu.

    % ���ݧѧӧߧ�� �ާ֧ߧ�
    main_menu :-
        write("1. ���ѧۧ�� �ѧ��֧ܧ�, �ԧէ� �ݧ֧ܧѧ���ӧ� ��ѧާ�� �է֧�֧ӧ��."), nl,
        write("2. �����ӧ֧�ڧ�� �ߧѧݧڧ�ڧ� �ݧ֧ܧѧ���ӧ� �� ����֧է֧ݧ֧ߧߧ�� �ѧ��֧ܧ�."), nl,
        write("3. ������ڧ�ݧڧ�� ���֧էߧ�� ��֧ߧ� �٧ѧէѧߧߧ�ԧ� �ݧ֧ܧѧ���ӧ�."), nl,
        write("4. ��������."), nl,
        write("���ӧ֧էڧ�� �ߧ�ާ֧� �ܧ�ާѧߧէ�: "),
        read(Command),
        process_command(Command).

    % ���ҧ�ѧҧ��ܧ� �ܧ�ާѧߧէ�
    process_command(1) :-
        write("���ӧ֧էڧ�� �ߧѧ٧ӧѧߧڧ� �ݧ֧ܧѧ���ӧ�: "),
        read(Medication),
        write("���ӧ֧էڧ�� �ܧ�ݧڧ�֧��ӧ�: "),
        read(Quantity),
        findall([Medication, Price, Pharmacy, Address], cheapest_pharmacy(Medication, Quantity, Pharmacy, Address, Price), Result),
        print_list(Result),
        main_menu.

    process_command(2) :-
        write("���ӧ֧էڧ�� �ߧѧ٧ӧѧߧڧ� �ݧ֧ܧѧ���ӧ�: "),
        read(Medication),
        write("���ӧ֧էڧ�� �ܧ�� �ѧ��֧ܧ�: "),
        read(PharmacyID),
        findall([Medication, Price, Quantity], available_at(Medication, PharmacyID, Price, Quantity), Result),
        print_list(Result),
        main_menu.

    process_command(3) :-
        write("���ӧ֧էڧ�� �ߧѧ٧ӧѧߧڧ� �ݧ֧ܧѧ���ӧ�: "),
        read(Medication),
        findall(Price, available_at(Medication, _, Price, _), Prices),
        calculate_average(Prices, AveragePrice),
        write("����֧էߧ�� ��֧ߧ� �էݧ� �ݧ֧ܧѧ���ӧ� "),
        write(Medication),
        write(" �����ѧӧݧ�֧� "),
        write(AveragePrice),
        write("."), nl,
        main_menu.

    process_command(4) :-
        write("�������� �ڧ� ����ԧ�ѧާާ�."), nl.

    process_command(_) :-
        write("���֧ܧ���֧ܧ�ߧѧ� �ܧ�ާѧߧէ�."), nl,
        main_menu.

    % ����ѧӧڧݧ� �էݧ� ����ӧ֧�ܧ� �ߧѧݧڧ�ڧ� �ݧ֧ܧѧ���ӧ� �� �ѧ��֧ܧ�
    available_at(Medication, PharmacyID, Price, Quantity) :-
        medication(MedID, Medication),
        pharmacy(PharmacyID, _, _, _),
        sales(PharmacyID, MedID, Price, Quantity).

    % ����ѧӧڧݧ� �էݧ� ���ڧ�ܧ� ��ѧާ�� �է֧�֧ӧ�� �ѧ��֧ܧ�, �ԧէ� �է�����ߧ� �ݧ֧ܧѧ���ӧ�
    cheapest_pharmacy(Medication, Quantity, PharmacyID, Address, Price) :-
        available_at(Medication, PharmacyID, Price, Quantity),
        not((available_at(Medication, OtherPharmacy, OtherPrice, _), OtherPrice < Price)),
        pharmacy(PharmacyID, _, Address, _).

    % ����ѧӧڧݧ� �էݧ� �ӧ��ӧ�է� ��ݧ֧ާ֧ߧ��� ���ڧ�ܧ�
    print_list([]).
    print_list([[Medication, Price, Pharmacy, Address] | Rest]) :-
        write("���֧ܧѧ���ӧ�: "), write(Medication),
        write(", ���֧ߧ�: "), write(Price),
        write(", �����֧ܧ�: "), write(Pharmacy),
        write(", ���է�֧�: "), write(Address),
        nl,
        print_list(Rest).

    % ����ѧӧڧݧ� �էݧ� �ӧ���ڧ�ݧ֧ߧڧ� ���֧էߧ֧ԧ� �٧ߧѧ�֧ߧڧ� ���ڧ�ܧ�
    calculate_average(List, Average) :-
        sum_list(List, Sum),
        length(List, Length),
        Average is Sum / Length.