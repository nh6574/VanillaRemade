-- Derived from SMODS code

SMODS.Sticker {
    key = "eternal",
    badge_colour = HEX 'c75985',
    pos = { x = 0, y = 0 },
    should_apply = function(self, card, center, area, bypass_roll)
        return G.GAME.modifiers.enable_eternals_in_shop and not card.perishable and card.config.center.eternal_compat
    end,
}

local smods_is_eternal_ref = SMODS.is_eternal
function SMODS.is_eternal(card, trigger)
    return card.ability.vremade_eternal or smods_is_eternal_ref(card, trigger)
end

SMODS.Sticker {
    key = "perishable",
    badge_colour = HEX '4f5da1',
    pos = { x = 0, y = 2 },
    should_apply = function(self, card, center, area, bypass_roll)
        return G.GAME.modifiers.enable_perishables_in_shop and not card.eternal and card.config.center.perishable_compat
    end,
    apply = function(self, card, val)
        card.ability[self.key] = val
        if card.ability[self.key] then card.ability.perish_tally = G.GAME.perishable_rounds end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.perishable_rounds or 5, card.ability.perish_tally or G.GAME.perishable_rounds } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.individual then
            card:calculate_perishable()
        end
    end
}

SMODS.Sticker {
    key = "rental",
    badge_colour = HEX 'b18f43',
    pos = { x = 1, y = 2 },
    should_apply = function(self, card, center, area, bypass_roll)
        return G.GAME.modifiers.enable_rentals_in_shop
    end,
    apply = function(self, card, val)
        card.ability[self.key] = val
        if card.ability[self.key] then card:set_cost() end -- Rental is hard-coded in Card:set_cost() to set the applied card's cost to $1
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.rental_rate or 1 } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.individual then
            card:calculate_rental()
        end
    end
}

--Pinned is a non-traditional sticker in that it doesn't appear naturally and has its functionality
--handled via CardArea:align_cards() in cardarea.lua
SMODS.Sticker {
    key = "pinned",
    badge_colour = HEX 'fda200',
    pos = { x = 10, y = 10 },
    rate = 0,
    apply = function(self, card, val)
        card.ability[self.key] = val
    end
}
