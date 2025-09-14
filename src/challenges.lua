-- The Omelette
SMODS.Challenge {
    key = 'omelette_1',
    rules = {
        custom = {
            { id = 'no_reward' },
            { id = 'no_extra_hand_money' },
            { id = 'no_interest' },
        }
    },
    jokers = {
        { id = 'j_egg' },
        { id = 'j_egg' },
        { id = 'j_egg' },
        { id = 'j_egg' },
        { id = 'j_egg' },
    },
    restrictions = {
        banned_cards = {
            { id = 'v_seed_money' },
            { id = 'v_money_tree' },
            { id = 'j_to_the_moon' },
            { id = 'j_rocket' },
            { id = 'j_golden' },
            { id = 'j_satellite' },
        }
    }
}

-- 15 Minute City
SMODS.Challenge {
    key = 'city_1',
    jokers = {
        { id = 'j_ride_the_bus', eternal = true },
        { id = 'j_shortcut',     eternal = true },
    },
    deck = {
        type = 'Challenge Deck',
        cards = {
            { s = 'C', r = 'K' },
            { s = 'C', r = 'K' },
            { s = 'D', r = 'K' },
            { s = 'D', r = 'K' },
            { s = 'H', r = 'K' },
            { s = 'H', r = 'K' },
            { s = 'S', r = 'K' },
            { s = 'S', r = 'K' },
            { s = 'C', r = 'Q' },
            { s = 'C', r = 'Q' },
            { s = 'D', r = 'Q' },
            { s = 'D', r = 'Q' },
            { s = 'H', r = 'Q' },
            { s = 'H', r = 'Q' },
            { s = 'S', r = 'Q' },
            { s = 'S', r = 'Q' },
            { s = 'C', r = 'J' },
            { s = 'C', r = 'J' },
            { s = 'D', r = 'J' },
            { s = 'D', r = 'J' },
            { s = 'H', r = 'J' },
            { s = 'H', r = 'J' },
            { s = 'S', r = 'J' },
            { s = 'S', r = 'J' },
            { s = 'C', r = 'T' },
            { s = 'D', r = 'T' },
            { s = 'H', r = 'T' },
            { s = 'S', r = 'T' },
            { s = 'C', r = '9' },
            { s = 'D', r = '9' },
            { s = 'H', r = '9' },
            { s = 'S', r = '9' },
            { s = 'C', r = '8' },
            { s = 'D', r = '8' },
            { s = 'H', r = '8' },
            { s = 'S', r = '8' },
            { s = 'C', r = '7' },
            { s = 'D', r = '7' },
            { s = 'H', r = '7' },
            { s = 'S', r = '7' },
            { s = 'C', r = '6' },
            { s = 'D', r = '6' },
            { s = 'H', r = '6' },
            { s = 'S', r = '6' },
            { s = 'C', r = '5' },
            { s = 'D', r = '5' },
            { s = 'H', r = '5' },
            { s = 'S', r = '5' },
            { s = 'C', r = '4' },
            { s = 'D', r = '4' },
            { s = 'H', r = '4' },
            { s = 'S', r = '4' },
        }
    }
}

-- Rich get Richer
SMODS.Challenge {
    key = 'rich_1',
    rules = {
        custom = {
            { id = 'chips_dollar_cap' },
        },
        modifiers = {
            { id = 'dollars', value = 100 },
        }
    },
    vouchers = {
        { id = 'v_seed_money' },
        { id = 'v_money_tree' },
    }
}

-- On a Knife's Edge
SMODS.Challenge {
    key = 'knife_1',
    jokers = {
        { id = 'j_ceremonial', pinned = true, eternal = true },
    }
}

-- X-ray Vision
SMODS.Challenge {
    key = 'xray_1',
    rules = {
        custom = {
            { id = 'flipped_cards', value = 4 },
        }
    }
}

-- Mad World
SMODS.Challenge {
    key = 'mad_world_1',
    rules = {
        custom = {
            { id = 'no_extra_hand_money' },
            { id = 'no_interest' },
        }
    },
    jokers = {
        { id = 'j_pareidolia', eternal = true, edition = "negative" },
        { id = 'j_business',   eternal = true },
    },
    restrictions = {
        banned_other = {
            { id = 'bl_plant', type = 'blind' },
        }
    },
    deck = {
        type = 'Challenge Deck',
        no_ranks = {
            T = true,
            J = true,
            Q = true,
            K = true,
            A = true,
        }
    }
}

-- Luxury Tax
SMODS.Challenge {
    key = 'luxury_1',
    rules = {
        custom = {
            { id = 'minus_hand_size_per_X_dollar', value = 5 },
        },
        modifiers = {
            { id = 'hand_size', value = 10 },
        }
    }
}

-- Non-Perishable
SMODS.Challenge {
    key = 'non_perishable_1',
    rules = {
        custom = {
            { id = 'all_eternal' },
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'j_gros_michel' },
            { id = 'j_cavendish' },
            { id = 'j_ice_cream' },
            { id = 'j_turtle_bean' },
            { id = 'j_ramen' },
            { id = 'j_diet_cola' },
            { id = 'j_selzer' },
            { id = 'j_popcorn' },
            { id = 'j_mr_bones' },
            { id = 'j_invisible' },
            { id = 'j_luchador' },
        },
        banned_other = {
            { id = 'bl_final_leaf', type = 'blind' },
        }
    }
}

-- Medusa
SMODS.Challenge {
    key = 'medusa_1',
    jokers = {
        { id = 'j_marble', eternal = true },
    },
    deck = {
        type = 'Challenge Deck',
        cards = {
            { s = 'C', r = 'A' },
            { s = 'D', r = 'A' },
            { s = 'H', r = 'A' },
            { s = 'S', r = 'A' },
            { s = 'C', r = 'K', e = 'm_stone' },
            { s = 'D', r = 'K', e = 'm_stone' },
            { s = 'H', r = 'K', e = 'm_stone' },
            { s = 'S', r = 'K', e = 'm_stone' },
            { s = 'C', r = 'Q', e = 'm_stone' },
            { s = 'D', r = 'Q', e = 'm_stone' },
            { s = 'H', r = 'Q', e = 'm_stone' },
            { s = 'S', r = 'Q', e = 'm_stone' },
            { s = 'C', r = 'J', e = 'm_stone' },
            { s = 'D', r = 'J', e = 'm_stone' },
            { s = 'H', r = 'J', e = 'm_stone' },
            { s = 'S', r = 'J', e = 'm_stone' },
            { s = 'C', r = 'T' },
            { s = 'D', r = 'T' },
            { s = 'H', r = 'T' },
            { s = 'S', r = 'T' },
            { s = 'C', r = '9' },
            { s = 'D', r = '9' },
            { s = 'H', r = '9' },
            { s = 'S', r = '9' },
            { s = 'C', r = '8' },
            { s = 'D', r = '8' },
            { s = 'H', r = '8' },
            { s = 'S', r = '8' },
            { s = 'C', r = '7' },
            { s = 'D', r = '7' },
            { s = 'H', r = '7' },
            { s = 'S', r = '7' },
            { s = 'C', r = '6' },
            { s = 'D', r = '6' },
            { s = 'H', r = '6' },
            { s = 'S', r = '6' },
            { s = 'C', r = '5' },
            { s = 'D', r = '5' },
            { s = 'H', r = '5' },
            { s = 'S', r = '5' },
            { s = 'C', r = '4' },
            { s = 'D', r = '4' },
            { s = 'H', r = '4' },
            { s = 'S', r = '4' },
            { s = 'C', r = '3' },
            { s = 'D', r = '3' },
            { s = 'H', r = '3' },
            { s = 'S', r = '3' },
            { s = 'C', r = '2' },
            { s = 'D', r = '2' },
            { s = 'H', r = '2' },
            { s = 'S', r = '2' },
        }
    }
}

-- Double or Nothing
SMODS.Challenge {
    key = 'double_nothing_1',
    rules = {
        custom = {
            { id = 'debuff_played_cards' },
        },
    },
    deck = {
        type = 'Challenge Deck',
        seal = 'Red'
    }
}

-- Typecast
SMODS.Challenge {
    key = 'typecast_1',
    rules = {
        custom = {
            { id = 'set_eternal_ante',     value = 4 },
            { id = 'set_joker_slots_ante', value = 4 },
        }
    },
    restrictions = {
        banned_other = {
            { id = 'bl_final_leaf', type = 'blind' },
        }
    }
}

-- Inflation
SMODS.Challenge {
    key = 'inflation_1',
    rules = {
        custom = {
            { id = 'inflation' },
        }
    },
    jokers = {
        { id = 'j_credit_card' },
    },
    restrictions = {
        banned_cards = {
            { id = 'v_clearance_sale' },
            { id = 'v_liquidation' },
        }
    },
}

-- Bram Poker
SMODS.Challenge {
    key = 'bram_poker_1',
    rules = {
        custom = {
            { id = 'no_shop_jokers' },
        }
    },
    jokers = {
        { id = 'j_vampire', eternal = true },
    },
    consumeables = {
        { id = 'c_emperor' },
        { id = 'c_empress' },
    },
    vouchers = {
        { id = 'v_magic_trick' },
        { id = 'v_illusion' },
    }
}

-- Fragile
SMODS.Challenge {
    key = 'fragile_1',
    jokers = {
        { id = 'j_oops', eternal = true, edition = 'negative' },
        { id = 'j_oops', eternal = true, edition = 'negative' },
    },
    restrictions = {
        banned_cards = {
            { id = 'j_marble' },
            { id = 'j_vampire' },
            { id = 'j_midas_mask' },
            { id = 'j_certificate' },
            { id = 'c_magician' },
            { id = 'c_empress' },
            { id = 'c_heirophant' },
            { id = 'c_chariot' },
            { id = 'c_devil' },
            { id = 'c_tower' },
            { id = 'c_lovers' },
            { id = 'c_incantation' },
            { id = 'c_grim' },
            { id = 'c_familiar' },
            { id = 'v_magic_trick' },
            { id = 'v_illusion' },
            { id = 'p_standard_normal_1', ids = {
                'p_standard_normal_1', 'p_standard_normal_2',
                'p_standard_normal_3', 'p_standard_normal_4',
                'p_standard_jumbo_1', 'p_standard_jumbo_2',
                'p_standard_mega_1', 'p_standard_mega_2' }
            },
        },
        banned_tags = {
            { id = 'tag_standard' },
        }
    },
    deck = {
        type = 'Challenge Deck',
        enhancement = 'm_glass'
    }
}

-- Monolith
SMODS.Challenge {
    key = 'monolith_1',
    jokers = {
        { id = 'j_obelisk', eternal = true },
        { id = 'j_marble',  eternal = true, edition = 'negative' },
    },
}

-- Blast Off
SMODS.Challenge {
    key = 'blast_off_1',
    rules = {
        modifiers = {
            { id = 'hands',       value = 2 },
            { id = 'discards',    value = 2 },
            { id = 'joker_slots', value = 4 },
        }
    },
    jokers = {
        { id = 'j_constellation', eternal = true },
        { id = 'j_rocket',        eternal = true },
    },
    vouchers = {
        { id = 'v_planet_merchant' },
        { id = 'v_planet_tycoon' },
    },
    restrictions = {
        banned_cards = {
            { id = 'v_grabber' },
            { id = 'v_nacho_tong' },
            { id = 'j_burglar' },
        }
    }
}

-- Five-Card Draw
SMODS.Challenge {
    key = 'five_card_1',
    rules = {
        modifiers = {
            { id = 'discards',    value = 6 },
            { id = 'hand_size',   value = 5 },
            { id = 'joker_slots', value = 7 },
        }
    },
    jokers = {
        { id = 'j_card_sharp' },
        { id = 'j_joker' },
    },
    restrictions = {
        banned_cards = {
            { id = 'j_juggler' },
            { id = 'j_troubadour' },
            { id = 'j_turtle_bean' },
        }
    }
}

-- Golden Needle
SMODS.Challenge {
    key = 'golden_needle_1',
    rules = {
        custom = {
            { id = 'discard_cost', value = 1 },
        },
        modifiers = {
            { id = 'hands',    value = 1 },
            { id = 'discards', value = 6 },
            { id = 'dollars',  value = 10 },
        }
    },
    jokers = {
        { id = 'j_credit_card' },
    },
    restrictions = {
        banned_cards = {
            { id = 'j_burglar' },
            { id = 'v_grabber' },
            { id = 'v_nacho_tong' },
        }
    },
}

-- Cruelty
SMODS.Challenge {
    key = 'cruelty_1',
    rules = {
        custom = {
            { id = 'no_reward_specific', value = 'Small' },
            { id = 'no_reward_specific', value = 'Big' },
        },
        modifiers = {
            { id = 'joker_slots', value = 3 },
        }
    }
}

-- Jokerless
SMODS.Challenge {
    key = 'jokerless_1',
    rules = {
        custom = {
            { id = 'no_shop_jokers' },
        },
        modifiers = {
            { id = 'joker_slots', value = 0 },
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'c_judgement' },
            { id = 'c_wraith' },
            { id = 'c_soul' },
            { id = 'p_buffoon_normal_1', ids = {
                'p_buffoon_normal_1', 'p_buffoon_normal_2', 'p_buffoon_jumbo_1', 'p_buffoon_mega_1',
            }
            },
        },
        banned_tags = {
            { id = 'tag_uncommon' },
            { id = 'tag_rare' },
            { id = 'tag_negative' },
            { id = 'tag_foil' },
            { id = 'tag_holographic' },
            { id = 'tag_polychrome' },
            { id = 'tag_buffoon' },
            { id = 'tag_top_up' },
        },
        banned_other = {
            { id = 'bl_final_heart', type = 'blind' },
            { id = 'bl_final_leaf',  type = 'blind' },
            { id = 'bl_final_acorn', type = 'blind' },
        }
    }
}
