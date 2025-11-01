-- Red Deck
SMODS.Back {
    key = "red",
    pos = { x = 0, y = 0 },
    config = { discards = 1 },
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.discards } }
    end,
    -- The config field already handles the functionality so it doesn't need to be implemented
    -- The following is how the implementation would be
    --[[
    apply = function(self, back)
        G.GAME.starting_params.discards = G.GAME.starting_params.discards + self.config.discards
    end
    ]]
}

-- Blue Deck
SMODS.Back {
    key = "blue",
    pos = { x = 0, y = 2 },
    config = { hands = 1 },
    unlocked = false,
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.hands } }
    end,
    -- The config field already handles the functionality so it doesn't need to be implemented
    -- The following is how the implementation would be
    --[[
    apply = function(self, back)
        G.GAME.starting_params.hands = G.GAME.starting_params.hands + self.config.extra.hands
    end,
    ]]
    locked_loc_vars = function(self, info_queue, back)
        return { vars = { 20 } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'discover_amount' and args.amount >= 20
    end
}

-- Yellow Deck
SMODS.Back {
    key = "yellow",
    pos = { x = 1, y = 2 },
    config = { dollars = 10 },
    unlocked = false,
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.dollars } }
    end,
    -- The config field already handles the functionality so it doesn't need to be implemented
    -- The following is how the implementation would be
    --[[
    apply = function(self, back)
        G.GAME.starting_params.dollars = G.GAME.starting_params.dollars + self.config.dollars
    end,
    ]]
    locked_loc_vars = function(self, info_queue, back)
        return { vars = { 50 } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'discover_amount' and args.amount >= 50
    end
}

-- Green Deck
SMODS.Back {
    key = "green",
    pos = { x = 2, y = 2 },
    config = { extra_hand_bonus = 2, extra_discard_bonus = 1, no_interest = true },
    unlocked = false,
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.extra_hand_bonus, self.config.extra_discard_bonus } }
    end,
    -- The config field already handles the functionality so it doesn't need to be implemented
    -- The following is how the implementation would be
    --[[
    apply = function(self, back)
        G.GAME.modifiers.money_per_hand = self.config.extra_hand_bonus
        G.GAME.modifiers.money_per_discard = self.config.extra_discard_bonus
        G.GAME.modifiers.no_interest = true
    end,
    ]]
    locked_loc_vars = function(self, info_queue, back)
        return { vars = { 75 } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'discover_amount' and args.amount >= 75
    end
}

-- Black Deck
SMODS.Back {
    key = "black",
    pos = { x = 3, y = 2 },
    config = { hands = -1, joker_slot = 1 },
    unlocked = false,
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.joker_slot, self.config.hands } }
    end,
    -- The config field already handles the functionality so it doesn't need to be implemented
    -- The following is how the implementation would be
    --[[
    apply = function(self, back)
        G.GAME.starting_params.hands = G.GAME.starting_params.hands + self.config.hands
        G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots + self.config.joker_slot
    end,
    ]]
    locked_loc_vars = function(self, info_queue, back)
        return { vars = { 100 } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'discover_amount' and args.amount >= 100
    end
}

-- Magic Deck
SMODS.Back {
    key = "magic",
    pos = { x = 0, y = 3 },
    config = { voucher = 'v_crystal_ball', consumables = { 'c_fool', 'c_fool' } },
    unlocked = false,
    loc_vars = function(self, info_queue, back)
        return {
            vars = { localize { type = 'name_text', key = self.config.voucher, set = 'Voucher' },
                localize { type = 'name_text', key = self.config.consumables[1], set = 'Tarot' }
            }
        }
    end,
    -- The config field already handles the functionality so it doesn't need to be implemented
    -- The following is how the implementation would be
    --[[
    apply = function(self, back)
        -- Apply the voucher
        G.GAME.used_vouchers[self.config.voucher] = true
        G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
        G.E_MANAGER:add_event(Event({ -- Adding back objects of any type from a deck MUST be done within an event
            func = function()
                back.apply_to_run(nil, G.P_CENTERS[self.config.voucher])
                return true
            end
        }))

        -- Apply the consumables
        delay(0.4)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in ipairs(self.config.consumables) do
                    SMODS.add_card({ key = v })
                end
                return true
            end
        }))
    end,
    ]]
    locked_loc_vars = function(self, info_queue, back)
        local other_name = localize('k_unknown')
        if G.P_CENTERS['b_red'].unlocked then
            other_name = localize { type = 'name_text', set = 'Back', key = 'b_red' }
        end

        return { vars = { other_name } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_deck' and get_deck_win_stake('b_red') and true
    end
}

-- Nebula Deck
SMODS.Back {
    key = "nebula",
    pos = { x = 3, y = 0 },
    config = { voucher = 'v_telescope', consumable_slot = -1 },
    unlocked = false,
    loc_vars = function(self, info_queue, back)
        return { vars = { localize { type = 'name_text', key = self.config.voucher, set = 'Voucher' }, self.config.consumable_slot } }
    end,
    -- The config field already handles the functionality so it doesn't need to be implemented
    -- The following is how the implementation would be
    --[[
    apply = function(self, back)
        -- Apply the voucher
        G.GAME.used_vouchers[self.config.voucher] = true
        G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
        G.E_MANAGER:add_event(Event({
            func = function()
                back.apply_to_run(nil, G.P_CENTERS[self.config.voucher])
                return true
            end
        }))

        -- Apply the consumable slot deduction
        G.GAME.starting_params.consumable_slots = G.GAME.starting_params.consumable_slots +
            self.config.consumable_slot
    end,
    ]]
    locked_loc_vars = function(self, info_queue, back)
        local other_name = localize('k_unknown')
        if G.P_CENTERS['b_blue'].unlocked then
            other_name = localize { type = 'name_text', set = 'Back', key = 'b_blue' }
        end

        return { vars = { other_name } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_deck' and get_deck_win_stake('b_blue') and true
    end
}

-- Ghost Deck
SMODS.Back {
    key = "ghost",
    pos = { x = 6, y = 2 },
    config = { spectral_rate = 2, consumables = { 'c_hex' } },
    unlocked = false,
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.spectral_rate, self.config.consumables[1] } }
    end,
    -- The config field already handles the functionality so it doesn't need to be implemented
    -- The following is how the implementation would be
    --[[
    apply = function(self, back)
        -- Apply the spectral rate
        G.GAME.spectral_rate = self.config.spectral_rate

        -- Apply the consumables
        delay(0.4)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in ipairs(self.config.extra.consumables) do
                    SMODS.add_card({ key = v })
                end
                return true
            end
        }))
    end,
    ]]
    locked_loc_vars = function(self, info_queue, back)
        local other_name = localize('k_unknown')
        if G.P_CENTERS['b_yellow'].unlocked then
            other_name = localize { type = 'name_text', set = 'Back', key = 'b_yellow' }
        end

        return { vars = { other_name } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_deck' and get_deck_win_stake('b_yellow') and true
    end
}

-- Abandoned Deck
SMODS.Back {
    key = "abandoned",
    pos = { x = 3, y = 3 },
    unlocked = false,
    config = { no_faces = true },
    -- The config field already handles the functionality so it doesn't need to be implemented
    -- The following is how the implementation would be
    --[[
    apply = function(self, back)
        G.GAME.starting_params.no_faces = true
    end,
    ]]
    locked_loc_vars = function(self, info_queue, back)
        local other_name = localize('k_unknown')
        if G.P_CENTERS['b_green'].unlocked then
            other_name = localize { type = 'name_text', set = 'Back', key = 'b_green' }
        end

        return { vars = { other_name } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_deck' and get_deck_win_stake('b_green') > 0
    end
}

-- Checkered Deck
SMODS.Back {
    key = "checkered",
    pos = { x = 1, y = 3 },
    unlocked = false,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    if v.base.suit == 'Clubs' then
                        v:change_suit('Spades')
                    end
                    if v.base.suit == 'Diamonds' then
                        v:change_suit('Hearts')
                    end
                end
                return true
            end
        }))
    end,
    locked_loc_vars = function(self, info_queue, back)
        local other_name = localize('k_unknown')
        if G.P_CENTERS['b_black'].unlocked then
            other_name = localize { type = 'name_text', set = 'Back', key = 'b_black' }
        end

        return { vars = { other_name } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_deck' and get_deck_win_stake('b_black') > 1
    end
}

-- Zodiac Deck
SMODS.Back {
    key = "zodiac",
    pos = { x = 3, y = 4 },
    config = { vouchers = { 'v_tarot_merchant', 'v_planet_merchant', 'v_overstock_norm' } },
    unlocked = false,
    loc_vars = function(self, info_queue, back)
        return {
            vars = { localize { type = 'name_text', key = self.config.vouchers[1], set = 'Voucher' },
                localize { type = 'name_text', key = self.config.vouchers[2], set = 'Voucher' },
                localize { type = 'name_text', key = self.config.vouchers[3], set = 'Voucher' }
            }
        }
    end,
    -- The config field already handles the functionality so it doesn't need to be implemented
    -- The following is how the implementation would be
    --[[
    apply = function(self, back)
        for k, v in pairs(self.config.vouchers) do
            G.GAME.used_vouchers[v] = true
            G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    back.apply_to_run(nil, G.P_CENTERS[v])
                    return true
                end
            }))
        end
    end,
    ]]
    locked_loc_vars = function(self, info_queue, back)
        return {
            vars = {
                localize { type = 'name_text', set = 'Stake', key = 'stake_red' },
                -- The colours table is a table within vars{} that can be used for variable colors in loc_vars
                colours = { get_stake_col(2) }
            }
        }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_stake' and get_deck_win_stake() >= 2
    end
}

-- Painted Deck
SMODS.Back {
    key = "painted",
    pos = { x = 4, y = 3 },
    config = { hand_size = 2, joker_slot = -1 },
    unlocked = false,
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.hand_size, self.config.joker_slot } }
    end,
    -- The config field already handles the functionality so it doesn't need to be implemented
    -- The following is how the implementation would be
    --[[
    apply = function(self, back)
        G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + self.config.extra.hand_size
        G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots + self.config.extra.joker_slot
    end,
    ]]
    locked_loc_vars = function(self, info_queue, back)
        return {
            vars = {
                localize { type = 'name_text', set = 'Stake', key = 'stake_green' },
                colours = { get_stake_col(3) }
            }
        }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_stake' and get_deck_win_stake() >= 3
    end
}

-- Anaglyph Deck
SMODS.Back {
    key = "anaglyph",
    pos = { x = 2, y = 4 },
    unlocked = false,
    loc_vars = function(self, info_queue, back)
        return { vars = { localize { type = 'name_text', key = 'tag_double', set = 'Tag' } } }
    end,
    calculate = function(self, back, context)
        if context.round_eval and G.GAME.last_blind and G.GAME.last_blind.boss then
            G.E_MANAGER:add_event(Event({
                func = function()
                    add_tag(Tag('tag_double'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))
        end
    end,
    locked_loc_vars = function(self, info_queue, back)
        return {
            vars = {
                localize { type = 'name_text', set = 'Stake', key = 'stake_black' },
                colours = { get_stake_col(4) }
            }
        }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_stake' and get_deck_win_stake() >= 4
    end
}

-- Plasma Deck
SMODS.Back {
    key = "plasma",
    pos = { x = 4, y = 2 },
    config = { ante_scaling = 2 },
    unlocked = false,
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.ante_scaling } }
    end,
    calculate = function(self, back, context)
        if context.final_scoring_step then
            return {
                balance = true
            }
        end
    end,
    -- The config field already handles the functionality so it doesn't need to be implemented
    -- The following is how the implementation would be
    --[[
    apply = function(self, back)
        G.GAME.starting_params.ante_scaling = self.config.ante_scaling
    end,
    ]]
    locked_loc_vars = function(self, info_queue, back)
        return {
            vars = {
                localize { type = 'name_text', set = 'Stake', key = 'stake_blue' },
                colours = { get_stake_col(5) }
            }
        }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_stake' and get_deck_win_stake() >= 5
    end
}

-- Erratic Deck
SMODS.Back {
    key = "erratic",
    pos = { x = 2, y = 3 },
    unlocked = false,
    config = { randomize_rank_suit = true },
    -- The config field already handles the functionality so it doesn't need to be implemented
    -- The following is how the implementation would be
    --[[
    apply = function(self, back)
        G.GAME.starting_params.erratic_suits_and_ranks = true
    end,
    ]]
    locked_loc_vars = function(self, info_queue, back)
        return {
            vars = {
                localize { type = 'name_text', set = 'Stake', key = 'stake_orange' },
                colours = { get_stake_col(7) }
            }
        }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_stake' and get_deck_win_stake() >= 7
    end
}
