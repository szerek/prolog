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
    % §©§Ñ§Ô§â§å§Ù§Ü§Ñ §Ò§Ñ§Ù§í §æ§Ñ§Ü§ä§à§Ó §Ú§Ù §æ§Ñ§Û§Ý§Ñ
    run(FileName) :-
        consult(FileName),
        write("§¢§Ñ§Ù§Ñ §æ§Ñ§Ü§ä§à§Ó §Ù§Ñ§Ô§â§å§Ø§Ö§ß§Ñ."), nl,
        main_menu.

    % §¤§Ý§Ñ§Ó§ß§à§Ö §Þ§Ö§ß§ð
    main_menu :-
        write("1. §¯§Ñ§Û§ä§Ú §Ñ§á§ä§Ö§Ü§å, §Ô§Õ§Ö §Ý§Ö§Ü§Ñ§â§ã§ä§Ó§à §ã§Ñ§Þ§à§Ö §Õ§Ö§ê§Ö§Ó§à§Ö."), nl,
        write("2. §±§â§à§Ó§Ö§â§Ú§ä§î §ß§Ñ§Ý§Ú§é§Ú§Ö §Ý§Ö§Ü§Ñ§â§ã§ä§Ó§Ñ §Ó §à§á§â§Ö§Õ§Ö§Ý§Ö§ß§ß§à§Û §Ñ§á§ä§Ö§Ü§Ö."), nl,
        write("3. §£§í§é§Ú§ã§Ý§Ú§ä§î §ã§â§Ö§Õ§ß§ð§ð §è§Ö§ß§å §Ù§Ñ§Õ§Ñ§ß§ß§à§Ô§à §Ý§Ö§Ü§Ñ§â§ã§ä§Ó§Ñ."), nl,
        write("4. §£§í§ç§à§Õ."), nl,
        write("§£§Ó§Ö§Õ§Ú§ä§Ö §ß§à§Þ§Ö§â §Ü§à§Þ§Ñ§ß§Õ§í: "),
        read(Command),
        process_command(Command).

    % §°§Ò§â§Ñ§Ò§à§ä§Ü§Ñ §Ü§à§Þ§Ñ§ß§Õ§í
    process_command(1) :-
        write("§£§Ó§Ö§Õ§Ú§ä§Ö §ß§Ñ§Ù§Ó§Ñ§ß§Ú§Ö §Ý§Ö§Ü§Ñ§â§ã§ä§Ó§Ñ: "),
        read(Medication),
        write("§£§Ó§Ö§Õ§Ú§ä§Ö §Ü§à§Ý§Ú§é§Ö§ã§ä§Ó§à: "),
        read(Quantity),
        findall([Medication, Price, Pharmacy, Address], cheapest_pharmacy(Medication, Quantity, Pharmacy, Address, Price), Result),
        print_list(Result),
        main_menu.

    process_command(2) :-
        write("§£§Ó§Ö§Õ§Ú§ä§Ö §ß§Ñ§Ù§Ó§Ñ§ß§Ú§Ö §Ý§Ö§Ü§Ñ§â§ã§ä§Ó§Ñ: "),
        read(Medication),
        write("§£§Ó§Ö§Õ§Ú§ä§Ö §Ü§à§Õ §Ñ§á§ä§Ö§Ü§Ú: "),
        read(PharmacyID),
        findall([Medication, Price, Quantity], available_at(Medication, PharmacyID, Price, Quantity), Result),
        print_list(Result),
        main_menu.

    process_command(3) :-
        write("§£§Ó§Ö§Õ§Ú§ä§Ö §ß§Ñ§Ù§Ó§Ñ§ß§Ú§Ö §Ý§Ö§Ü§Ñ§â§ã§ä§Ó§Ñ: "),
        read(Medication),
        findall(Price, available_at(Medication, _, Price, _), Prices),
        calculate_average(Prices, AveragePrice),
        write("§³§â§Ö§Õ§ß§ñ§ñ §è§Ö§ß§Ñ §Õ§Ý§ñ §Ý§Ö§Ü§Ñ§â§ã§ä§Ó§Ñ "),
        write(Medication),
        write(" §ã§à§ã§ä§Ñ§Ó§Ý§ñ§Ö§ä "),
        write(AveragePrice),
        write("."), nl,
        main_menu.

    process_command(4) :-
        write("§£§í§ç§à§Õ §Ú§Ù §á§â§à§Ô§â§Ñ§Þ§Þ§í."), nl.

    process_command(_) :-
        write("§¯§Ö§Ü§à§â§â§Ö§Ü§ä§ß§Ñ§ñ §Ü§à§Þ§Ñ§ß§Õ§Ñ."), nl,
        main_menu.

    % §±§â§Ñ§Ó§Ú§Ý§à §Õ§Ý§ñ §á§â§à§Ó§Ö§â§Ü§Ú §ß§Ñ§Ý§Ú§é§Ú§ñ §Ý§Ö§Ü§Ñ§â§ã§ä§Ó§Ñ §Ó §Ñ§á§ä§Ö§Ü§Ö
    available_at(Medication, PharmacyID, Price, Quantity) :-
        medication(MedID, Medication),
        pharmacy(PharmacyID, _, _, _),
        sales(PharmacyID, MedID, Price, Quantity).

    % §±§â§Ñ§Ó§Ú§Ý§à §Õ§Ý§ñ §á§à§Ú§ã§Ü§Ñ §ã§Ñ§Þ§à§Û §Õ§Ö§ê§Ö§Ó§à§Û §Ñ§á§ä§Ö§Ü§Ú, §Ô§Õ§Ö §Õ§à§ã§ä§å§á§ß§à §Ý§Ö§Ü§Ñ§â§ã§ä§Ó§à
    cheapest_pharmacy(Medication, Quantity, PharmacyID, Address, Price) :-
        available_at(Medication, PharmacyID, Price, Quantity),
        not((available_at(Medication, OtherPharmacy, OtherPrice, _), OtherPrice < Price)),
        pharmacy(PharmacyID, _, Address, _).

    % §±§â§Ñ§Ó§Ú§Ý§à §Õ§Ý§ñ §Ó§í§Ó§à§Õ§Ñ §ï§Ý§Ö§Þ§Ö§ß§ä§à§Ó §ã§á§Ú§ã§Ü§Ñ
    print_list([]).
    print_list([[Medication, Price, Pharmacy, Address] | Rest]) :-
        write("§­§Ö§Ü§Ñ§â§ã§ä§Ó§à: "), write(Medication),
        write(", §¸§Ö§ß§Ñ: "), write(Price),
        write(", §¡§á§ä§Ö§Ü§Ñ: "), write(Pharmacy),
        write(", §¡§Õ§â§Ö§ã: "), write(Address),
        nl,
        print_list(Rest).

    % §±§â§Ñ§Ó§Ú§Ý§à §Õ§Ý§ñ §Ó§í§é§Ú§ã§Ý§Ö§ß§Ú§ñ §ã§â§Ö§Õ§ß§Ö§Ô§à §Ù§ß§Ñ§é§Ö§ß§Ú§ñ §ã§á§Ú§ã§Ü§Ñ
    calculate_average(List, Average) :-
        sum_list(List, Sum),
        length(List, Length),
        Average is Sum / Length.