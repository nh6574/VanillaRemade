-- Small Blind
-- This won't show up in runs without extra code
SMODS.Blind {
    key = "small",
    dollars = 3,
    mult = 1,
    pos = { x = 0, y = 0 }
}

-- Big Blind
-- This won't show up in runs without extra code
SMODS.Blind {
    key = "big",
    dollars = 4,
    mult = 1.5,
    pos = { x = 0, y = 1 }
}

-- The Hook
SMODS.Blind {
    key = "hook",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 7 },
    boss = { min = 1 },
    boss_colour = HEX("a84024"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.press_play then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local any_selected = nil
                        local _cards = {}
                        for _, playing_card in ipairs(G.hand.cards) do
                            _cards[#_cards + 1] = playing_card
                        end
                        for i = 1, 2 do
                            if G.hand.cards[i] then
                                local selected_card, card_index = pseudorandom_element(_cards, 'vremade_hook')
                                G.hand:add_to_highlighted(selected_card, true)
                                table.remove(_cards, card_index)
                                any_selected = true
                                play_sound('card1', 1)
                            end
                        end
                        if any_selected then G.FUNCS.discard_cards_from_highlighted(nil, true) end
                        return true
                    end
                }))
                blind.triggered = true -- This won't trigger Matador in this context due to a Vanilla bug (a workaround is setting it in context.debuff_hand)
                delay(0.7)
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = (function()
                        SMODS.juice_up_blind()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.06 * G.SETTINGS.GAMESPEED,
                            blockable = false,
                            blocking = false,
                            func = function()
                                play_sound('tarot2', 0.76, 0.4); return true
                            end
                        }))
                        play_sound('tarot2', 1, 0.4)
                        return true
                    end)
                }))
                delay(0.4)
            end
        end
    end
}

-- The Ox
SMODS.Blind {
    key = "ox",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 2 },
    boss = { min = 6 },
    boss_colour = HEX("b95b08"),
    loc_vars = function(self)
        return { vars = { localize(G.GAME.current_round.most_played_poker_hand, 'poker_hands') } }
    end,
    collection_loc_vars = function(self)
        return { vars = { localize('ph_most_played') } }
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_hand then
                blind.triggered = false
                if context.scoring_name == G.GAME.current_round.most_played_poker_hand then
                    blind.triggered = true
                    if not context.check then
                        ease_dollars(-G.GAME.dollars, true) -- `return {dollars = -G.GAME.dollars}` lacks the ability to set the amount instantly
                        blind:wiggle()
                    end
                end
            end
        end
    end
}

-- The House
SMODS.Blind {
    key = "house",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 3 },
    boss = { min = 2 },
    boss_colour = HEX("5186a8"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.stay_flipped and context.to_area == G.hand and
                G.GAME.current_round.hands_played == 0 and G.GAME.current_round.discards_used == 0 then
                return {
                    stay_flipped = true
                }
            end
        end
    end,
    disable = function(self)
        for i = 1, #G.hand.cards do
            if G.hand.cards[i].facing == 'back' then
                G.hand.cards[i]:flip()
            end
        end
        for _, playing_card in pairs(G.playing_cards) do
            playing_card.ability.wheel_flipped = nil
        end
    end
}

-- The Wall
SMODS.Blind {
    key = "wall",
    dollars = 5,
    mult = 4,
    pos = { x = 0, y = 9 },
    boss = { min = 2 },
    boss_colour = HEX("8a59a5"),
    disable = function(self)
        G.GAME.blind.chips = G.GAME.blind.chips / 2
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    end
}

-- The Wheel
SMODS.Blind {
    key = "wheel",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 10 },
    boss = { min = 2 },
    boss_colour = HEX("50bf7c"),
    loc_vars = function(self)
        local numerator, denominator = SMODS.get_probability_vars(self, 1, 7, 'vremade_wheel')
        return { vars = { numerator, denominator } }
    end,
    collection_loc_vars = function(self)
        return { vars = { '1' } }
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.stay_flipped and context.to_area == G.hand and
                SMODS.pseudorandom_probability(blind, 'vremade_wheel', 1, 7) then
                return {
                    stay_flipped = true
                }
            end
        end
    end,
    disable = function(self)
        for i = 1, #G.hand.cards do
            if G.hand.cards[i].facing == 'back' then
                G.hand.cards[i]:flip()
            end
        end
        for _, playing_card in pairs(G.playing_cards) do
            playing_card.ability.wheel_flipped = nil
        end
    end
}

-- The Arm
SMODS.Blind {
    key = "arm",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 11 },
    boss = { min = 2 },
    boss_colour = HEX("6865f3"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_hand then
                blind.triggered = false
                if G.GAME.hands[context.scoring_name].level > 1 then
                    blind.triggered = true
                    if not context.check then
                        return {
                            level_up = -1
                        }
                    end
                end
            end
        end
    end
}

-- The Club
SMODS.Blind {
    key = "club",
    dollars = 5,
    mult = 2,
    debuff = { suit = "Clubs" },
    pos = { x = 0, y = 4 },
    boss = { min = 1 },
    boss_colour = HEX("b9cb92")
}

-- The Fish
SMODS.Blind {
    key = "fish",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 5 },
    boss = { min = 2 },
    boss_colour = HEX("3e85bd"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.press_play then
                blind.prepped = true
            end
            if context.stay_flipped and context.to_area == G.hand and blind.prepped then
                return {
                    stay_flipped = true
                }
            end
        end
        if context.setting_blind or context.hand_drawn then
            blind.prepped = nil
        end
    end,
    disable = function(self)
        for i = 1, #G.hand.cards do
            if G.hand.cards[i].facing == 'back' then
                G.hand.cards[i]:flip()
            end
        end
        for _, playing_card in pairs(G.playing_cards) do
            playing_card.ability.wheel_flipped = nil
        end
    end
}

-- The Psychic
SMODS.Blind {
    key = "psychic",
    dollars = 5,
    mult = 2,
    debuff = { h_size_ge = 5 },
    pos = { x = 0, y = 12 },
    boss = { min = 1 },
    boss_colour = HEX("efc03c")
}

-- The Goad
SMODS.Blind {
    key = "goad",
    dollars = 5,
    mult = 2,
    debuff = { suit = "Spades" },
    pos = { x = 0, y = 13 },
    boss = { min = 1 },
    boss_colour = HEX("b95c96")
}

-- The Water
SMODS.Blind {
    key = "water",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 14 },
    boss = { min = 2 },
    boss_colour = HEX("c6e0eb"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind then
                blind.discards_sub = G.GAME.current_round.discards_left
                ease_discard(-blind.discards_sub)
            end
        end
    end,
    disable = function(self)
        ease_discard(G.GAME.blind.discards_sub)
    end
}

-- The Window
SMODS.Blind {
    key = "window",
    dollars = 5,
    mult = 2,
    debuff = { suit = "Diamonds" },
    pos = { x = 0, y = 6 },
    boss = { min = 1 },
    boss_colour = HEX("a9a295")
}

-- The Manacle
SMODS.Blind {
    key = "manacle",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 8 },
    boss = { min = 1 },
    boss_colour = HEX("575757"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind then
                G.hand:change_size(-1)
            end
        end
    end,
    disable = function(self)
        G.hand:change_size(1)
    end,
    defeat = function(self)
        if not G.GAME.blind.disabled then
            G.hand:change_size(1)
        end
    end
}

-- The Eye
SMODS.Blind {
    key = "eye",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 17 },
    boss = { min = 3 },
    boss_colour = HEX("4b71e4"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind then
                blind.hands = {}
                for _, poker_hand in ipairs(G.handlist) do
                    blind.hands[poker_hand] = false
                end
            end
            if context.debuff_hand then
                if blind.hands[context.scoring_name] then
                    blind.triggered = true
                    return {
                        debuff = true
                    }
                end
                if not context.check then
                    blind.hands[context.scoring_name] = true
                end
            end
        end
    end
}

-- The Mouth
SMODS.Blind {
    key = "mouth",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 18 },
    boss = { min = 2 },
    boss_colour = HEX("ae718e"),
    get_loc_debuff_text = function(self)
        return G.GAME.blind.loc_debuff_text ..
            (G.GAME.blind.only_hand and ' [' .. localize(G.GAME.blind.only_hand, 'poker_hands') .. ']' or '')
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind then
                blind.only_hand = false
            end
            if context.debuff_hand then
                if blind.only_hand and blind.only_hand ~= context.scoring_name then
                    blind.triggered = true
                    return {
                        debuff = true
                    }
                end
                if not context.check then
                    blind.only_hand = context.scoring_name
                end
            end
        end
    end
}

-- The Plant
SMODS.Blind {
    key = "plant",
    dollars = 5,
    mult = 2,
    debuff = { is_face = true },
    pos = { x = 0, y = 19 },
    boss = { min = 4 },
    boss_colour = HEX("709284")
}

-- The Serpent
SMODS.Blind {
    key = "serpent",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 15 },
    boss = { min = 5 },
    boss_colour = HEX("439a4f"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.drawing_cards and (G.GAME.current_round.hands_played ~= 0 or G.GAME.current_round.discards_used ~= 0) then
                return {
                    cards_to_draw = 3
                }
            end
        end
    end
}

-- The Pillar
SMODS.Blind {
    key = "pillar",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 16 },
    boss = { min = 1 },
    boss_colour = HEX("7e6752"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_card and context.debuff_card.area ~= G.jokers and context.debuff_card.ability.played_this_ante then
                return {
                    debuff = true
                }
            end
        end
    end
}

-- The Needle
SMODS.Blind {
    key = "needle",
    dollars = 5,
    mult = 1,
    pos = { x = 0, y = 20 },
    boss = { min = 2 },
    boss_colour = HEX("5c6e31"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind then
                G.GAME.blind.hands_sub = G.GAME.round_resets.hands - 1
                ease_hands_played(-G.GAME.blind.hands_sub)
            end
        end
    end,
    disable = function(self)
        ease_hands_played(G.GAME.blind.hands_sub)
    end
}

-- The Head
SMODS.Blind {
    key = "head",
    dollars = 5,
    mult = 2,
    debuff = { suit = "Hearts" },
    pos = { x = 0, y = 21 },
    boss = { min = 1 },
    boss_colour = HEX("ac9db4")
}

-- The Tooth
SMODS.Blind {
    key = "tooth",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 22 },
    boss = { min = 3 },
    boss_colour = HEX("b52d2d"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.press_play then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        for i = 1, #G.play.cards do
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.play.cards[i]:juice_up()
                                    return true
                                end,
                            }))
                            ease_dollars(-1)
                            delay(0.23)
                        end
                        return true
                    end
                }))
                blind.triggered = true -- This won't trigger Matador in this context due to a Vanilla bug (a workaround is setting it in context.debuff_hand)
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = (function()
                        SMODS.juice_up_blind()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.06 * G.SETTINGS.GAMESPEED,
                            blockable = false,
                            blocking = false,
                            func = function()
                                play_sound('tarot2', 0.76, 0.4)
                                return true
                            end
                        }))
                        play_sound('tarot2', 1, 0.4)
                        return true
                    end)
                }))
                delay(0.4)
            end
        end
    end
}

-- The Flint
SMODS.Blind {
    key = "flint",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 24 },
    boss = { min = 2 },
    boss_colour = HEX("e56a2f"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.modify_hand then
                blind.triggered = true -- This won't trigger Matador in this context due to a Vanilla bug (a workaround is setting it in context.debuff_hand)
                mult = mod_mult(math.max(math.floor(mult * 0.5 + 0.5), 1))
                hand_chips = mod_chips(math.max(math.floor(hand_chips * 0.5 + 0.5), 0))
                update_hand_text({ sound = 'chips2', modded = true }, { chips = hand_chips, mult = mult })
            end
        end
    end
}

-- The Mark
SMODS.Blind {
    key = "mark",
    dollars = 5,
    mult = 2,
    pos = { x = 0, y = 23 },
    boss = { min = 2 },
    boss_colour = HEX("6a3847"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.stay_flipped and context.to_area == G.hand and
                context.other_card:is_face(true) then
                return {
                    stay_flipped = true
                }
            end
        end
    end,
    disable = function(self)
        for i = 1, #G.hand.cards do
            if G.hand.cards[i].facing == 'back' then
                G.hand.cards[i]:flip()
            end
        end
        for _, playing_card in pairs(G.playing_cards) do
            playing_card.ability.wheel_flipped = nil
        end
    end
}

-- Amber Acorn
SMODS.Blind {
    key = "final_acorn",
    dollars = 8,
    mult = 2,
    pos = { x = 0, y = 27 },
    boss = { showdown = true },
    boss_colour = HEX("fda200"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind then
                if #G.jokers.cards > 0 then
                    G.jokers:unhighlight_all()
                    for _, joker in ipairs(G.jokers.cards) do
                        joker:flip()
                    end
                    if #G.jokers.cards > 1 then
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.2,
                            func = function()
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        G.jokers:shuffle('aajk')
                                        play_sound('cardSlide1', 0.85)
                                        return true
                                    end,
                                }))
                                delay(0.15)
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        G.jokers:shuffle('aajk')
                                        play_sound('cardSlide1', 1.15)
                                        return true
                                    end
                                }))
                                delay(0.15)
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        G.jokers:shuffle('aajk')
                                        play_sound('cardSlide1', 1)
                                        return true
                                    end
                                }))
                                delay(0.5)
                                return true
                            end
                        }))
                    end
                end
            end
        end
    end,
}

-- Verdant Leaf
SMODS.Blind {
    key = "final_leaf",
    dollars = 8,
    mult = 2,
    pos = { x = 0, y = 28 },
    boss = { showdown = true },
    boss_colour = HEX("56a786"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_card and context.debuff_card.area ~= G.jokers then
                return {
                    debuff = true
                }
            end
            if context.selling_card and context.card.ability.set == 'Joker' then
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        blind:disable()
                        return true
                    end
                }))
            end
        end
    end
}

-- Violet Vessel
SMODS.Blind {
    key = "final_vessel",
    dollars = 8,
    mult = 6,
    pos = { x = 0, y = 29 },
    boss = { showdown = true },
    boss_colour = HEX("8a71e1"),
    disable = function(self)
        G.GAME.blind.chips = G.GAME.blind.chips / 3
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    end
}

-- Crimson Heart
SMODS.Blind {
    key = "final_heart",
    dollars = 8,
    mult = 2,
    pos = { x = 0, y = 25 },
    boss = { showdown = true },
    boss_colour = HEX("ac3232"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_card and context.debuff_card.area == G.jokers then
                if context.debuff_card.ability.crimson_heart_chosen then
                    return {
                        debuff = true
                    }
                end
            end
            if context.press_play and G.jokers.cards[1] then
                blind.triggered = true -- This won't trigger Matador in this context due to a Vanilla bug (a workaround is setting it in context.debuff_hand)
                blind.prepped = true
            end
            if context.hand_drawn then
                if blind.prepped and G.jokers.cards[1] then
                    local prev_chosen_set = {}
                    local fallback_jokers = {}
                    local jokers = {}
                    for i = 1, #G.jokers.cards do
                        if G.jokers.cards[i].ability.crimson_heart_chosen then
                            prev_chosen_set[G.jokers.cards[i]] = true
                            G.jokers.cards[i].ability.crimson_heart_chosen = nil
                            if G.jokers.cards[i].debuff then SMODS.recalc_debuff(G.jokers.cards[i]) end
                        end
                    end
                    for i = 1, #G.jokers.cards do
                        if not G.jokers.cards[i].debuff then
                            if not prev_chosen_set[G.jokers.cards[i]] then
                                jokers[#jokers + 1] = G.jokers.cards[i]
                            end
                            table.insert(fallback_jokers, G.jokers.cards[i])
                        end
                    end
                    if #jokers == 0 then jokers = fallback_jokers end
                    local _card = pseudorandom_element(jokers, 'vremade_crimson_heart')
                    if _card then
                        _card.ability.crimson_heart_chosen = true
                        SMODS.recalc_debuff(_card)
                        _card:juice_up()
                        blind:wiggle()
                    end
                end
            end
        end
        if context.hand_drawn then
            blind.prepped = nil
        end
    end,
    disable = function(self)
        for _, joker in ipairs(G.jokers.cards) do
            joker.ability.crimson_heart_chosen = nil
        end
    end,
    defeat = function(self)
        for _, joker in ipairs(G.jokers.cards) do
            joker.ability.crimson_heart_chosen = nil
        end
    end
}

-- Cerulean Bell
SMODS.Blind {
    key = "final_bell",
    dollars = 8,
    mult = 2,
    pos = { x = 0, y = 26 },
    boss = { showdown = true },
    boss_colour = HEX("009cfd"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.hand_drawn then
                local any_forced = nil
                for _, playing_card in ipairs(G.hand.cards) do
                    if playing_card.ability.forced_selection then
                        any_forced = true
                    end
                end
                if not any_forced then
                    G.hand:unhighlight_all()
                    local forced_card = pseudorandom_element(G.hand.cards, 'vremade_cerulean_bell')
                    forced_card.ability.forced_selection = true
                    G.hand:add_to_highlighted(forced_card)
                end
            end
        end
    end,
    disable = function(self)
        for _, playing_card in ipairs(G.playing_cards) do
            playing_card.ability.forced_selection = nil
        end
    end
}
