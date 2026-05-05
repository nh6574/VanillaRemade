--- Base parts copied from SMODS
--- It's recommended to check the vanilla functions for more information (they won't be replicated here)

SMODS.PokerHandPart {
    key = '_highest',
    func = function(hand) return get_highest(hand) end
}

SMODS.PokerHandPart {
    key = '_straight',
    func = function(hand)
        return get_straight(hand, SMODS.four_fingers('straight'), SMODS.shortcut(),
            SMODS.wrap_around_straight())
    end
}

SMODS.PokerHandPart {
    key = '_flush',
    func = function(hand) return get_flush(hand) end,
}

SMODS.PokerHandPart {
    key = '_all_pairs',
    func = function(hand)
        local _2 = get_X_same(2, hand, true)
        if not next(_2) then return {} end
        return { SMODS.merge_lists(_2) }
    end
}

SMODS.PokerHandPart {
    key = '_2',
    func = function(hand) return get_X_same(2, hand, true) end
}

SMODS.PokerHandPart {
    key = '_3',
    func = function(hand) return get_X_same(3, hand, true) end
}

SMODS.PokerHandPart {
    key = '_4',
    func = function(hand) return get_X_same(4, hand, true) end
}

SMODS.PokerHandPart {
    key = '_5',
    func = function(hand) return get_X_same(5, hand, true) end
}

--- Poker Hands

-- High Card
SMODS.PokerHand {
    key = "High Card",
    mult = 1,
    chips = 5,
    l_mult = 1,
    l_chips = 10,
    example = {
        { 'S_A', true },
        { 'D_Q', false },
        { 'D_9', false },
        { 'C_4', false },
        { 'D_3', false }
    },
    evaluate = function(parts, hand)
        return parts._highest
    end
}

-- Pair
SMODS.PokerHand {
    key = "Pair",
    mult = 2,
    chips = 10,
    l_mult = 1,
    l_chips = 15,
    example = {
        { 'S_K', false },
        { 'S_9', true },
        { 'D_9', true },
        { 'H_6', false },
        { 'D_3', false }
    },
    evaluate = function(parts, hand)
        return parts._2
    end
}

-- Two Pair
SMODS.PokerHand {
    key = "Two Pair",
    mult = 2,
    chips = 20,
    l_mult = 1,
    l_chips = 20,
    example = {
        { 'H_A', true },
        { 'D_A', true },
        { 'C_Q', false },
        { 'H_4', true },
        { 'C_4', true }
    },
    evaluate = function(parts, hand)
        if #parts._2 < 2 then return {} end
        return parts._all_pairs
    end
}

-- Three of a Kind
SMODS.PokerHand {
    key = "Three of a Kind",
    mult = 3,
    chips = 30,
    l_mult = 2,
    l_chips = 20,
    example = {
        { 'S_T', true },
        { 'C_T', true },
        { 'D_T', true },
        { 'H_6', false },
        { 'D_5', false }
    },
    evaluate = function(parts, hand)
        return parts._3
    end
}

-- Straight
SMODS.PokerHand {
    key = "Straight",
    mult = 4,
    chips = 30,
    l_mult = 3,
    l_chips = 30,
    example = {
        { 'D_J', true },
        { 'C_T', true },
        { 'C_9', true },
        { 'S_8', true },
        { 'H_7', true }
    },
    evaluate = function(parts, hand)
        return parts._straight
    end
}

-- Flush
SMODS.PokerHand {
    key = "Flush",
    mult = 4,
    chips = 35,
    l_mult = 2,
    l_chips = 15,
    example = {
        { 'H_A', true },
        { 'H_K', true },
        { 'H_T', true },
        { 'H_5', true },
        { 'H_4', true }
    },
    evaluate = function(parts, hand)
        return parts._flush
    end
}

-- Full House
SMODS.PokerHand {
    key = "Full House",
    mult = 4,
    chips = 40,
    l_mult = 2,
    l_chips = 25,
    example = {
        { 'H_K', true },
        { 'C_K', true },
        { 'D_K', true },
        { 'S_2', true },
        { 'D_2', true }
    },
    evaluate = function(parts, hand)
        if #parts._3 < 1 or #parts._2 < 2 then return {} end
        return parts._all_pairs
    end
}

-- Four of a Kind
SMODS.PokerHand {
    key = "Four of a Kind",
    mult = 7,
    chips = 60,
    l_mult = 3,
    l_chips = 30,
    example = {
        { 'S_J', true },
        { 'H_J', true },
        { 'C_J', true },
        { 'D_J', true },
        { 'C_3', false }
    },
    evaluate = function(parts, hand)
        return parts._4
    end
}

-- Straight Flush
SMODS.PokerHand {
    key = "Straight Flush",
    mult = 8,
    chips = 100,
    l_mult = 4,
    l_chips = 40,
    example = {
        { 'S_Q', true },
        { 'S_J', true },
        { 'S_T', true },
        { 'S_9', true },
        { 'S_8', true }
    },
    evaluate = function(parts, hand)
        if not next(parts._straight) or not next(parts._flush) then return end
        return { SMODS.merge_lists(parts._straight, parts._flush) }
    end,
    modify_display_text = function(self, cards, scoring_hand)
        local royal = true
        for j = 1, #scoring_hand do
            local rank = SMODS.Ranks[scoring_hand[j].base.value]
            royal = royal and (rank.key == 'Ace' or rank.key == '10' or rank.face)
        end
        if royal then
            return 'vremade_Royal Flush'
        end
    end
}

-- Five of a Kind
SMODS.PokerHand {
    key = "Five of a Kind",
    visible = false,
    mult = 12,
    chips = 120,
    l_mult = 3,
    l_chips = 35,
    example = {
        { 'S_A', true },
        { 'H_A', true },
        { 'H_A', true },
        { 'C_A', true },
        { 'D_A', true }
    },
    evaluate = function(parts, hand)
        return parts._5
    end
}

-- Flush House
SMODS.PokerHand {
    key = "Flush House",
    visible = false,
    mult = 14,
    chips = 140,
    l_mult = 4,
    l_chips = 40,
    example = {
        { 'D_7', true },
        { 'D_7', true },
        { 'D_7', true },
        { 'D_4', true },
        { 'D_4', true }
    },
    evaluate = function(parts, hand)
        if #parts._3 < 1 or #parts._2 < 2 or not next(parts._flush) then return {} end
        return { SMODS.merge_lists(parts._all_pairs, parts._flush) }
    end
}

-- Flush Five
SMODS.PokerHand {
    key = "Flush Five",
    visible = false,
    mult = 16,
    chips = 160,
    l_mult = 3,
    l_chips = 50,
    example = {
        { 'S_A', true },
        { 'S_A', true },
        { 'S_A', true },
        { 'S_A', true },
        { 'S_A', true }
    },
    evaluate = function(parts, hand)
        if not next(parts._5) or not next(parts._flush) then return {} end
        return { SMODS.merge_lists(parts._5, parts._flush) }
    end
}
