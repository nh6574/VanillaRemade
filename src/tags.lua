-- Uncommon Tag
SMODS.Tag {
    key = "uncommon",
    pos = { x = 0, y = 0 },
    apply = function(self, tag, context)
        if context.type == 'store_joker_create' then
            local card = SMODS.create_card {
                set = "Joker",
                rarity = "Uncommon",
                area = context.area,
                key_append = "vremade_uta"
            }
            create_shop_card_ui(card, 'Joker', context.area)
            card.states.visible = false
            tag:yep('+', G.C.GREEN, function()
                card:start_materialize()
                card.ability.couponed = true
                card:set_cost()
                return true
            end)
            tag.triggered = true
            return card
        end
    end
}

-- Rare Tag
SMODS.Tag {
    key = "rare",
    pos = { x = 1, y = 0 },
    config = { odds = 3 },
    apply = function(self, tag, context)
        if context.type == 'store_joker_create' then
            local rares_in_posession = { 0 }
            for _, joker in ipairs(G.jokers.cards) do
                if joker.config.center.rarity == 3 and not rares_in_posession[joker.config.center.key] then
                    rares_in_posession[1] = rares_in_posession[1] + 1
                    rares_in_posession[joker.config.center.key] = true
                end
            end
            if #G.P_JOKER_RARITY_POOLS[3] > rares_in_posession[1] then
                local card = SMODS.create_card {
                    set = "Joker",
                    rarity = "Rare",
                    area = context.area,
                    key_append = "vremade_rta"
                }
                create_shop_card_ui(card, 'Joker', context.area)
                card.states.visible = false
                tag:yep('+', G.C.RED, function()
                    card:start_materialize()
                    card.ability.couponed = true
                    card:set_cost()
                    return true
                end)
                tag.triggered = true
                return card
            else
                tag:nope()
            end
        end
    end,
    in_pool = function(self, args)
        return G.P_CENTERS["j_blueprint"].discovered
    end
}

-- Negative Tag
SMODS.Tag {
    key = "negative",
    min_ante = 2,
    pos = { x = 2, y = 0 },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
    end,
    apply = function(self, tag, context)
        if context.type == 'store_joker_modify' then
            if not context.card.edition and not context.card.temp_edition and context.card.ability.set == 'Joker' then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true
                context.card.temp_edition = true
                tag:yep('+', G.C.DARK_EDITION, function()
                    context.card.temp_edition = nil
                    context.card:set_edition("e_negative", true)
                    context.card.ability.couponed = true
                    context.card:set_cost()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                tag.triggered = true
                return true
            end
        end
    end,
    in_pool = function(self, args)
        return G.P_CENTERS["e_negative"].discovered
    end
}

-- Foil Tag
SMODS.Tag {
    key = "foil",
    pos = { x = 3, y = 0 },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
    end,
    apply = function(self, tag, context)
        if context.type == 'store_joker_modify' then
            if not context.card.edition and not context.card.temp_edition and context.card.ability.set == 'Joker' then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true
                context.card.temp_edition = true
                tag:yep('+', G.C.DARK_EDITION, function()
                    context.card.temp_edition = nil
                    context.card:set_edition("e_foil", true)
                    context.card.ability.couponed = true
                    context.card:set_cost()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                tag.triggered = true
                return true
            end
        end
    end,
    in_pool = function(self, args)
        return G.P_CENTERS["e_foil"].discovered
    end
}

-- Holographic Tag
SMODS.Tag {
    key = "holo",
    pos = { x = 0, y = 1 },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
    end,
    apply = function(self, tag, context)
        if context.type == 'store_joker_modify' then
            if not context.card.edition and not context.card.temp_edition and context.card.ability.set == 'Joker' then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true
                context.card.temp_edition = true
                tag:yep('+', G.C.DARK_EDITION, function()
                    context.card.temp_edition = nil
                    context.card:set_edition("e_holo", true)
                    context.card.ability.couponed = true
                    context.card:set_cost()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                tag.triggered = true
                return true
            end
        end
    end,
    in_pool = function(self, args)
        return G.P_CENTERS["e_holo"].discovered
    end
}

-- Polychrome Tag
SMODS.Tag {
    key = "polychrome",
    pos = { x = 1, y = 1 },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
    end,
    apply = function(self, tag, context)
        if context.type == 'store_joker_modify' then
            if not context.card.edition and not context.card.temp_edition and context.card.ability.set == 'Joker' then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true
                context.card.temp_edition = true
                tag:yep('+', G.C.DARK_EDITION, function()
                    context.card.temp_edition = nil
                    context.card:set_edition("e_polychrome", true)
                    context.card.ability.couponed = true
                    context.card:set_cost()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                tag.triggered = true
                return true
            end
        end
    end,
    in_pool = function(self, args)
        return G.P_CENTERS["e_polychrome"].discovered
    end
}

-- Investment Tag
SMODS.Tag {
    key = "investment",
    pos = { x = 2, y = 1 },
    config = { dollars = 25 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.dollars } }
    end,
    apply = function(self, tag, context)
        if context.type == 'eval' then
            if G.GAME.last_blind and G.GAME.last_blind.boss then
                tag:yep('+', G.C.GOLD, function()
                    return true
                end)
                tag.triggered = true
                return {
                    dollars = tag.config.dollars,
                    condition = localize('ph_defeat_the_boss'),
                    pos = tag.pos,
                    tag = tag
                }
            end
        end
    end
}

-- Voucher Tag
SMODS.Tag {
    key = "voucher",
    pos = { x = 3, y = 1 },
    apply = function(self, tag, context)
        if context.type == 'voucher_add' then
            tag:yep('+', G.C.SECONDARY_SET.Voucher, function()
                local voucher = SMODS.add_voucher_to_shop()
                voucher.from_tag = true
                return true
            end)
            tag.triggered = true
        end
    end
}

-- Boss Tag
SMODS.Tag {
    key = "boss",
    pos = { x = 0, y = 2 },
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.GREEN, function()
                G.from_boss_tag = true
                G.FUNCS.reroll_boss()

                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.CONTROLLER.locks[lock] = nil
                                return true
                            end
                        }))
                        return true
                    end
                }))

                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

-- Standard Tag
SMODS.Tag {
    key = "standard",
    min_ante = 2,
    pos = { x = 1, y = 2 },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_standard_mega_1
    end,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.SECONDARY_SET.Spectral, function()
                local booster = SMODS.create_card { key = 'p_standard_mega_1', area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

-- Charm Tag
SMODS.Tag {
    key = "charm",
    pos = { x = 2, y = 2 },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_arcana_mega_1
    end,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.PURPLE, function()
                local booster = SMODS.create_card { key = 'p_arcana_mega_' .. math.random(1, 2), area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

-- Meteor Tag
SMODS.Tag {
    key = "meteor",
    min_ante = 2,
    pos = { x = 3, y = 2 },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_celestial_mega_1
    end,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.SECONDARY_SET.Planet, function()
                local booster = SMODS.create_card { key = 'p_celestial_mega_' .. math.random(1, 2), area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

-- Buffoon Tag
SMODS.Tag {
    key = "buffoon",
    min_ante = 2,
    pos = { x = 4, y = 2 },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_buffoon_mega_1
    end,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.SECONDARY_SET.Spectral, function()
                local booster = SMODS.create_card { key = 'p_buffoon_mega_1', area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

-- Handy Tag
SMODS.Tag {
    key = "handy",
    min_ante = 2,
    pos = { x = 1, y = 3 },
    config = { dollars_per_hand = 1 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.dollars_per_hand, tag.config.dollars_per_hand * (G.GAME.hands_played or 0) } }
    end,
    apply = function(self, tag, context)
        if context.type == 'immediate' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.MONEY, function()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            ease_dollars((G.GAME.hands_played or 0) * tag.config.dollars_per_hand)
            tag.triggered = true
            return true
        end
    end
}

-- Garbage Tag
SMODS.Tag {
    key = "garbage",
    min_ante = 2,
    pos = { x = 2, y = 3 },
    config = { dollars_per_discard = 1 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.dollars_per_discard, tag.config.dollars_per_discard * (G.GAME.unused_discards or 0) } }
    end,
    apply = function(self, tag, context)
        if context.type == 'immediate' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.MONEY, function()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            ease_dollars((G.GAME.unused_discards or 0) * tag.config.dollars_per_discard)
            tag.triggered = true
            return true
        end
    end
}

-- Ethereal Tag
SMODS.Tag {
    key = "ethereal",
    min_ante = 2,
    pos = { x = 3, y = 3 },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_spectral_normal_1
    end,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.SECONDARY_SET.Spectral, function()
                local booster = SMODS.create_card { key = 'p_spectral_normal_1', area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

-- Coupon Tag
SMODS.Tag {
    key = "coupon",
    pos = { x = 4, y = 0 },
    apply = function(self, tag, context)
        if context.type == 'shop_final_pass' and G.shop and not G.GAME.shop_free then
            G.GAME.shop_free = true
            tag:yep('+', G.C.GREEN, function()
                if G.shop_jokers and G.shop_booster then
                    for _, card in pairs(G.shop_jokers.cards) do
                        card.ability.couponed = true
                        card:set_cost()
                    end
                    for _, booster in pairs(G.shop_booster.cards) do
                        booster.ability.couponed = true
                        booster:set_cost()
                    end
                end
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

-- Double Tag
SMODS.Tag {
    key = "double",
    pos = { x = 5, y = 0 },
    apply = function(self, tag, context)
        if context.type == 'tag_add' and context.tag.key ~= 'tag_double' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.BLUE, function()
                if context.tag.ability and context.tag.ability.orbital_hand then
                    G.orbital_hand = context.tag.ability.orbital_hand
                end
                add_tag(Tag(context.tag.key))
                G.orbital_hand = nil
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
        end
    end
}

-- Juggle Tag
SMODS.Tag {
    key = "juggle",
    pos = { x = 5, y = 1 },
    config = { h_size = 3 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.h_size } }
    end,
    apply = function(self, tag, context)
        if context.type == 'round_start_bonus' then
            tag:yep('+', G.C.BLUE, function()
                return true
            end)
            G.hand:change_size(tag.config.h_size)
            G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + tag.config.h_size
            tag.triggered = true
            return true
        end
    end
}

-- D6 Tag
SMODS.Tag {
    key = "d_six",
    pos = { x = 5, y = 3 },
    apply = function(self, tag, context)
        if context.type == 'shop_start' and not G.GAME.shop_d6ed then
            G.GAME.shop_d6ed = true
            tag:yep('+', G.C.GREEN, function()
                G.GAME.round_resets.temp_reroll_cost = 0
                calculate_reroll_cost(true)
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

-- Top-up Tag
SMODS.Tag {
    key = "top_up",
    min_ante = 2,
    pos = { x = 4, y = 1 },
    config = { spawn_jokers = 2 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.spawn_jokers } }
    end,
    apply = function(self, tag, context)
        if context.type == 'immediate' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.PURPLE, function()
                for _ = 1, tag.config.spawn_jokers do
                    if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
                        SMODS.add_card {
                            set = "Joker",
                            rarity = "Common",
                            key_append = "vremade_top"
                        }
                    end
                end
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

-- Speed Tag
SMODS.Tag {
    key = "skip",
    pos = { x = 0, y = 3 },
    config = { skip_bonus = 5 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.skip_bonus, tag.config.skip_bonus * ((G.GAME.skips or 0) + 1) } }
    end,
    apply = function(self, tag, context)
        if context.type == 'immediate' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.MONEY, function()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            ease_dollars((G.GAME.skips or 0) * tag.config.skip_bonus)
            tag.triggered = true
            return true
        end
    end
}

-- Orbital Tag
SMODS.Tag {
    key = "orbital",
    min_ante = 2,
    pos = { x = 5, y = 2 },
    config = { levels = 3 },
    loc_vars = function(self, info_queue, tag)
        return {
            vars = {
                (tag.ability.orbital_hand == '[' .. localize('k_poker_hand') .. ']') and tag.ability.orbital_hand or
                localize(tag.ability.orbital_hand, 'poker_hands'), tag.config.levels }
        }
    end,
    set_ability = function(self, tag)
        if G.orbital_hand then
            tag.ability.orbital_hand = G.orbital_hand
        elseif tag.ability.blind_type then
            if G.GAME.orbital_choices and G.GAME.orbital_choices[G.GAME.round_resets.ante][tag.ability.blind_type] then
                tag.ability.orbital_hand = G.GAME.orbital_choices[G.GAME.round_resets.ante][tag.ability.blind_type]
            end
        end
    end,
    apply = function(self, tag, context)
        if context.type == 'immediate' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            SMODS.upgrade_poker_hands({ from = tag, hands = { tag.ability.orbital_hand }, level_up = tag.config.levels })
            tag:yep('+', G.C.MONEY, function()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

-- Economy Tag
SMODS.Tag {
    key = "economy",
    pos = { x = 4, y = 3 },
    config = { max = 40 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.max } }
    end,
    apply = function(self, tag, context)
        if context.type == 'immediate' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.MONEY, function()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    ease_dollars(math.min(tag.config.max, math.max(0, G.GAME.dollars)), true)
                    return true
                end
            }))
            tag.triggered = true
            return true
        end
    end
}
