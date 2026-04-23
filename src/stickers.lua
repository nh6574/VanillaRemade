-- Derived from SMODS code

SMODS.Sticker {
    key = "eternal",
    badge_colour = HEX('c75985'),
    pos = { x = 0, y = 0 },
    needs_enable_flag = true,
    should_apply = function(self, card, center, area, bypass_roll)
        -- The perishable check can't be done here because of timing, so the vanilla condition is impossible to recreate with the API
        return G.GAME.modifiers.enable_eternals_in_shop and
            SMODS.Sticker.should_apply(self, card, center, area, bypass_roll) -- this handles the enable flag and rate
    end,
}

local smods_is_eternal_ref = SMODS.is_eternal
function SMODS.is_eternal(card, trigger)
    return card.ability.vremade_eternal or smods_is_eternal_ref(card, trigger)
end

SMODS.Sticker {
    key = "perishable",
    badge_colour = HEX('4f5da1'),
    pos = { x = 0, y = 2 },
    config = {
        perish_tally = 5
    },
    needs_enable_flag = true,
    should_apply = function(self, card, center, area, bypass_roll)
        -- The eternal check can't be done here because of timing, so the vanilla condition is impossible to recreate with the API
        return G.GAME.modifiers.enable_perishables_in_shop and
            SMODS.Sticker.should_apply(self, card, center, area, bypass_roll) -- this handles the enable flag and rate
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { 5, card.ability.vremade_perishable.perish_tally } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false then
            if card.ability.vremade_perishable.perish_tally > 0 then
                if card.ability.vremade_perishable.perish_tally == 1 then
                    card.ability.vremade_perishable.perish_tally = 0
                    return {
                        message = localize('k_disabled_ex'),
                        colour = G.C.FILTER,
                        delay = 0.45,
                        func = function()
                            card:set_debuff(true)
                        end
                    }
                else
                    card.ability.vremade_perishable.perish_tally = card.ability.vremade_perishable.perish_tally - 1
                    return {
                        message = localize { type = 'variable', key = 'a_remaining', vars = { card.ability.vremade_perishable.perish_tally } },
                        colour = G.C.FILTER,
                        delay = 0.45
                    }
                end
            end
        end
    end
}

SMODS.Sticker {
    key = "rental",
    badge_colour = HEX('b18f43'),
    pos = { x = 1, y = 2 },
    needs_enable_flag = true,
    apply = function(self, card, val)
        SMODS.Sticker.apply(self, card, val)
        if card.ability[self.key] then card:set_cost() end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.rental_rate or 1 } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false then
            return {
                dollars = -G.GAME.rental_rate,
            }
        end
    end
}

-- Rental is hard-coded in Card:set_cost() to set the applied card's cost to $1
local set_cost_value_ref = Card.set_cost_value
function Card:set_cost_value(...) -- SMODS addition
    if self.ability.vremade_rental then self.cost = 1 end
    return set_cost_value_ref(self, ...)
end

--Pinned is a non-traditional sticker in that it doesn't appear naturally and has its functionality
--handled via CardArea:align_cards() in cardarea.lua
SMODS.Sticker {
    key = "pinned",
    badge_colour = HEX('fda200'),
    pos = { x = 10, y = 10 },
    rate = 0
}
