-- Overstock
SMODS.Voucher {
    key = 'overstock_norm',
    pos = { x = 0, y = 0 },
    config = { extra = { shop_size = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.shop_size } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                change_shop_size(card.ability.extra.shop_size)
                return true
            end
        }))
    end
}

-- Overstock Plus
SMODS.Voucher {
    key = 'overstock_plus',
    pos = { x = 0, y = 1 },
    config = { extra = { shop_size = 1 } },
    unlocked = false,
    requires = { 'v_vremade_overstock_norm' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.shop_size } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                change_shop_size(card.ability.extra.shop_size)
                return true
            end
        }))
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 2500, G.PROFILES[G.SETTINGS.profile].career_stats.c_shop_dollars_spent } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'c_shop_dollars_spent' and
            G.PROFILES[G.SETTINGS.profile].career_stats.c_shop_dollars_spent >= 2500
    end
}

-- Clearance Sale
SMODS.Voucher {
    key = 'clearance_sale',
    pos = { x = 3, y = 0 },
    config = { extra = { percent = 25 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.percent } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.discount_percent = card.ability.extra.percent
                for _, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end
}

-- Liquidation
SMODS.Voucher {
    key = 'liquidation',
    pos = { x = 3, y = 1 },
    config = { extra = { percent = 50 } },
    unlocked = false,
    requires = { 'v_vremade_clearance_sale' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.percent } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.discount_percent = card.ability.extra.percent
                for _, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 10 } }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'run_redeem' then
            local vouchers_redeemed = 0
            for _, _ in pairs(G.GAME.used_vouchers) do
                vouchers_redeemed = vouchers_redeemed + 1
            end
            return vouchers_redeemed >= 10
        end
        return false
    end
}

-- Hone
SMODS.Voucher {
    key = 'hone',
    pos = { x = 4, y = 0 },
    config = { extra = { rate = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.rate } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.edition_rate = card.ability.extra.rate
                return true
            end
        }))
    end
}

-- Glow Up
SMODS.Voucher {
    key = 'glow_up',
    pos = { x = 4, y = 1 },
    config = { extra = { rate = 4 } },
    unlocked = false,
    requires = { 'v_vremade_hone' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.rate } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.edition_rate = card.ability.extra.rate
                return true
            end
        }))
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 5 } }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'have_edition' then
            local shiny_jokers = 0
            for _, joker in ipairs(G.jokers.cards) do
                if joker.edition then shiny_jokers = shiny_jokers + 1 end
            end
            return shiny_jokers >= 5
        end
        return false
    end
}

-- Reroll Surplus
SMODS.Voucher {
    key = 'reroll_surplus',
    pos = { x = 4, y = 0 },
    config = { extra = { deduction = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.deduction } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost - card.ability.extra.deduction
                G.GAME.current_round.reroll_cost = math.max(0,
                    G.GAME.current_round.reroll_cost - card.ability.extra.deduction)
                return true
            end
        }))
    end
}

-- Reroll Glut
SMODS.Voucher {
    key = 'reroll_glut',
    pos = { x = 4, y = 1 },
    config = { extra = { deduction = 2 } },
    unlocked = false,
    requires = { 'v_vremade_reroll_surplus' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.deduction } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost - card.ability.extra.deduction
                G.GAME.current_round.reroll_cost = math.max(0,
                    G.GAME.current_round.reroll_cost - card.ability.extra.deduction)
                return true
            end
        }))
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 100, G.PROFILES[G.SETTINGS.profile].career_stats.c_shop_rerolls } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'c_shop_rerolls' and G.PROFILES[G.SETTINGS.profile].career_stats.c_shop_rerolls >= 100
    end
}

-- Crystal Ball
SMODS.Voucher {
    key = 'crystal_ball',
    pos = { x = 2, y = 2 },
    config = { extra = { slots = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.slots } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.slots
                return true
            end
        }))
    end
}

-- Omen Globe
SMODS.Voucher {
    key = 'omen_globe',
    pos = { x = 2, y = 3 },
    unlocked = false,
    requires = { 'v_vremade_crystal_ball' },
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 25, G.PROFILES[G.SETTINGS.profile].career_stats.c_shop_rerolls } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'c_tarot_reading_used' and G.PROFILES[G.SETTINGS.profile].career_stats.c_shop_rerolls >= 25
    end
}

SMODS.Booster:take_ownership_by_kind('Arcana', {
        create_card = function(self, card, i)
            local _card
            if (G.GAME.used_vouchers.v_omen_globe and pseudorandom('omen_globe') > 0.8) or (G.GAME.used_vouchers.v_vremade_omen_globe and pseudorandom('vremade_omen_globe') > 0.8) then
                _card = {
                    set = "Spectral",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key_append =
                    "ar2"
                }
            else
                _card = {
                    set = "Tarot",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key_append =
                    "ar1"
                }
            end
            return _card
        end,
    },
    true
)

-- Telescope
SMODS.Voucher {
    key = 'telescope',
    pos = { x = 3, y = 2 },
}

SMODS.Booster:take_ownership_by_kind('Celestial', {
        create_card = function(self, card, i)
            local _card
            if (G.GAME.used_vouchers.v_telescope or G.GAME.used_vouchers.v_vremade_telescope) and i == 1 then
                local _planet, _hand, _tally = nil, nil, 0
                for _, handname in ipairs(G.handlist) do
                    if SMODS.is_poker_hand_visible(handname) and G.GAME.hands[handname].played > _tally then
                        _hand = handname
                        _tally = G.GAME.hands[handname].played
                    end
                end
                if _hand then
                    for _, v in pairs(G.P_CENTER_POOLS.Planet) do
                        if v.config.hand_type == _hand then
                            _planet = v.key
                        end
                    end
                end
                _card = {
                    set = "Planet",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key = _planet,
                    key_append = "pl1"
                }
            else
                _card = {
                    set = "Planet",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key_append =
                    "pl1"
                }
            end
            return _card
        end,
        loc_vars = function(self, info_queue, card)
            local cfg = (card and card.ability) or self.config
            return {
                vars = { cfg.choose, cfg.extra },
                key = self.key:sub(1, -3), -- This uses the description key of the booster without the number at the end
            }
        end,
    },
    true
)

-- Observatory
SMODS.Voucher {
    key = 'observatory',
    pos = { x = 3, y = 3 },
    config = { extra = { Xmult = 1.5 } },
    unlocked = false,
    requires = { 'v_vremade_telescope' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
        if context.other_consumeable and context.other_consumable.ability.set == 'Planet' and context.other_consumable.ability.consumeable.hand_type == context.scoring_name then
            return {
                x_mult = card.ability.extra.Xmult,
                message_card = context.other_consumable
            }
        end
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 25, G.PROFILES[G.SETTINGS.profile].career_stats.c_planetarium_used } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'c_planetarium_used' and G.PROFILES[G.SETTINGS.profile].career_stats.c_planetarium_used >= 25
    end
}

-- Grabber
SMODS.Voucher {
    key = 'grabber',
    pos = { x = 5, y = 0 },
    config = { extra = { hands = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hands } }
    end,
    redeem = function(self, card)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
        ease_hands_played(card.ability.extra.hands)
    end
}

-- Nacho Tong
SMODS.Voucher {
    key = 'nacho_tong',
    pos = { x = 5, y = 1 },
    config = { extra = { hands = 1 } },
    unlocked = false,
    requires = { 'v_vremade_grabber' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hands } }
    end,
    redeem = function(self, card)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
        ease_hands_played(card.ability.extra.hands)
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 2500, G.PROFILES[G.SETTINGS.profile].career_stats.c_cards_played } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'c_cards_played' and G.PROFILES[G.SETTINGS.profile].career_stats[args.statname] >= 2500
    end
}

-- Wasteful
SMODS.Voucher {
    key = 'wasteful',
    pos = { x = 6, y = 0 },
    config = { extra = { discards = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.discards } }
    end,
    redeem = function(self, card)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
        ease_discard(card.ability.extra.discards)
    end
}

-- Recyclomancy
SMODS.Voucher {
    key = 'recyclomancy',
    pos = { x = 6, y = 1 },
    config = { extra = { discards = 1 } },
    unlocked = false,
    requires = { 'v_vremade_telescope' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.discards } }
    end,
    redeem = function(self, card)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
        ease_discard(card.ability.extra.discards)
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 2500, G.PROFILES[G.SETTINGS.profile].career_stats.c_cards_discarded } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'c_cards_discarded' and G.PROFILES[G.SETTINGS.profile].career_stats[args.statname] >= 2500
    end
}

-- Tarot Merchant
SMODS.Voucher {
    key = 'tarot_merchant',
    pos = { x = 1, y = 0 },
    config = { extra = { rate = 2.4, display = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.display } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.tarot_rate = 4 * card.ability.extra.rate
                return true
            end
        }))
    end
}

-- Tarot Tycoon
SMODS.Voucher {
    key = 'tarot_tycoon',
    pos = { x = 1, y = 1 },
    config = { extra = { rate = 8, display = 4 } },
    unlocked = false,
    requires = { 'v_vremade_tarot_merchant' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.display, } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.tarot_rate = 4 * card.ability.extra.rate
                return true
            end
        }))
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 50, G.PROFILES[G.SETTINGS.profile].career_stats.c_tarots_bought } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'c_tarots_bought' and G.PROFILES[G.SETTINGS.profile].career_stats.c_tarots_bought >= 50
    end
}

-- Planet Merchant
SMODS.Voucher {
    key = 'planet_merchant',
    pos = { x = 2, y = 0 },
    config = { extra = { rate = 2.4, display = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.display } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.planet_rate = 4 * card.ability.extra.rate
                return true
            end
        }))
    end
}

-- Planet Tycoon
SMODS.Voucher {
    key = 'planet_tycoon',
    pos = { x = 2, y = 1 },
    config = { extra = { rate = 8, display = 4 } },
    unlocked = false,
    requires = { 'v_vremade_planet_merchant' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.display, } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.planet_rate = 4 * card.ability.extra.rate
                return true
            end
        }))
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 50, G.PROFILES[G.SETTINGS.profile].career_stats.c_planets_bought } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'c_planets_bought' and G.PROFILES[G.SETTINGS.profile].career_stats.c_planets_bought >= 50
    end
}

-- Seed Money
SMODS.Voucher {
    key = 'seed_money',
    pos = { x = 1, y = 2 },
    config = { extra = { cap = 50 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cap } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.interest_cap = card.ability.extra.cap
                return true
            end
        }))
    end
}

-- Money Tree
SMODS.Voucher {
    key = 'money_tree',
    pos = { x = 1, y = 3 },
    config = { extra = { cap = 100 } },
    unlocked = false,
    requires = { 'v_vremade_seed_money' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cap } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.interest_cap = card.ability.extra.cap
                return true
            end
        }))
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 10, G.PROFILES[G.SETTINGS.profile].career_stats.c_round_interest_cap_streak } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'interest_streak' and
            G.PROFILES[G.SETTINGS.profile].career_stats.c_round_interest_cap_streak >= 10
    end
}

-- Blank
SMODS.Voucher {
    key = 'blank',
    pos = { x = 7, y = 0 },
    redeem = function(self, card)
        check_for_unlock({ 'vremade_blank_redeems' })
    end
}

-- Antimatter
SMODS.Voucher {
    key = 'antimatter',
    pos = { x = 7, y = 1 },
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' and (card.config.center.discovered or card.bypass_discovery_center) then
            card.children.center:draw_shader('negative', nil, card.ARGS.send_to_shader)
            card.children.center:draw_shader('negative_shine', nil, card.ARGS.send_to_shader)
        end
    end,
    config = { extra = { slots = 1 } },
    unlocked = false,
    requires = { 'v_vremade_blank' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.slots } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                if G.jokers then
                    G.jokers.config.card_limit = G.jokers.config.card_limit + 1
                end
                return true
            end,
        }))
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 10, G.PROFILES[G.SETTINGS.profile].voucher_usage.v_vremade_blank and G.PROFILES[G.SETTINGS.profile].voucher_usage.v_vremade_blank.count or 0 } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'vremade_blank_redeems' and G.PROFILES[G.SETTINGS.profile].voucher_usage['v_vremade_blank'] and
            G.PROFILES[G.SETTINGS.profile].voucher_usage['v_remade_blank'].count >= 10
    end,
}

-- Magic Trick
SMODS.Voucher {
    key = 'magic_trick',
    pos = { x = 4, y = 2 },
    config = { extra = { rate = 4 } },
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.playing_card_rate = card.ability.extra.rate
                return true
            end
        }))
    end
}

-- Illusion | The enhancement portion of Illusion is handled in functions/UI_definitions.lua
-- and would require a Lovely patch or a hook to replicate
SMODS.Voucher {
    key = 'illusion',
    pos = { x = 4, y = 3 },
    config = { extra = { rate = 4 } },
    unlocked = false,
    requires = { 'v_vremade_magic_trick' },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.playing_card_rate = card.ability.extra.rate
                return true
            end
        }))
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 20, G.PROFILES[G.SETTINGS.profile].career_stats.c_playing_cards_bought } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'c_playing_cards_bought' and
            G.PROFILES[G.SETTINGS.profile].career_stats.c_playing_cards_bought >= 20
    end
}

-- Hieroglyph
SMODS.Voucher {
    key = 'hieroglyph',
    pos = { x = 5, y = 2 },
    config = { extra = { deduction = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.deduction } }
    end,
    redeem = function(self, card)
        -- Apply ante change
        ease_ante(-card.ability.extra.deduction)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - card.ability.extra.deduction

        -- Apply hand change
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.deduction
        ease_hands_played(-card.ability.extra.deduction)
    end
}

-- Petroglyph
SMODS.Voucher {
    key = 'petroglyph',
    pos = { x = 5, y = 3 },
    config = { extra = { deduction = 1 } },
    unlocked = false,
    requires = { 'v_vremade_hieroglyph' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.deduction } }
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 12 } }
    end,
    redeem = function(self, card)
        -- Apply ante change
        ease_ante(-card.ability.extra.deduction)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - card.ability.extra.deduction

        -- Apply discard change
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.deduction
        ease_discard(-card.ability.extra.deduction)
    end,
    check_for_unlock = function(self, args)
        return args.type == 'ante_up' and args.ante >= 12
    end
}

-- Director's Cut | Director's Cut and Retcon both do not have a redeem functions. The game handles
-- their functions inside G.FUNCS.reroll_boss_button in functions/button_callbacks.lua
SMODS.Voucher {
    key = 'directors_cut',
    pos = { x = 6, y = 2 },
    config = { extra = { money = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money } }
    end
}

-- Retcon
SMODS.Voucher {
    key = 'retcon',
    pos = { x = 6, y = 3 },
    config = { extra = { money = 10 } },
    unlocked = false,
    requires = { 'v_vremade_directors_cut' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money } }
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 25 } }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'blind_discoveries' then
            local discovered_blinds = 0
            for k, v in pairs(G.P_BLINDS) do
                if v.discovered then
                    discovered_blinds = discovered_blinds + 1
                end
            end
            return discovered_blinds >= 25
        end
        return false
    end
}

-- Paint Brush
SMODS.Voucher {
    key = 'paint_brush',
    pos = { x = 7, y = 2 },
    config = { extra = { size = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.size } }
    end,
    redeem = function(self, card)
        G.hand:change_size(card.ability.extra.size)
    end
}

-- Palette
SMODS.Voucher {
    key = 'palette',
    pos = { x = 7, y = 3 },
    config = { extra = { size = 1 } },
    unlocked = false,
    requires = { 'v_vremade_paint_brush' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.size } }
    end,
    redeem = function(self, card)
        G.hand:change_size(card.ability.extra.size)
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 5 } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'min_hand_size' and G.hand and G.hand.config.card_limit <= 5
    end
}
