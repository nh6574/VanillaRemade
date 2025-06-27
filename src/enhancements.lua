-- Bonus
SMODS.Enhancement {
    key = 'bonus',
    pos = { x = 1, y = 1 },
    config = { bonus = 30 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.bonus } }
    end,
}

-- Mult
SMODS.Enhancement {
    key = 'mult',
    pos = { x = 2, y = 1 },
    config = { mult = 4 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.mult } }
    end,
}

-- Wild
SMODS.Enhancement {
    key = 'wild',
    pos = { x = 3, y = 1 },
    any_suit = true
}

-- Glass
SMODS.Enhancement {
    key = 'glass',
    pos = { x = 5, y = 1 },
    config = { Xmult = 2, extra = { odds = 4 } },
    shatters = true,
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return { vars = { card.ability.Xmult, numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.destroy_card and context.cardarea == G.play and context.destroy_card == card and
            SMODS.pseudorandom_probability(card, 'vremade_glass', 1, card.ability.extra.odds) then
            return { remove = true }
        end
    end,
}

-- Steel
SMODS.Enhancement {
    key = 'steel',
    pos = { x = 6, y = 1 },
    config = { h_x_mult = 1.5 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.h_x_mult } }
    end,
}

-- Stone
SMODS.Enhancement {
    key = 'stone',
    pos = { x = 5, y = 0 },
    config = { bonus = 50 },
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.bonus } }
    end,
}

-- Gold
SMODS.Enhancement {
    key = 'gold',
    pos = { x = 6, y = 0 },
    config = { h_dollars = 3 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.h_dollars } }
    end,
}

-- Lucky
SMODS.Enhancement {
    key = 'lucky',
    pos = { x = 4, y = 1 },
    -- We can't use 'mult' or 'p_dollars' outside of 'extra' here because they would be scored unconditionally if we did
    config = { extra = { mult = 20, dollars = 20, mult_odds = 5, dollars_odds = 15 } },
    loc_vars = function(self, info_queue, card)
        local mult_numerator, mult_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.mult_odds)
        local dollars_numerator, dollars_denominator = SMODS.get_probability_vars(card, 1,
            card.ability.extra.dollars_odds)
        return { vars = { mult_numerator, dollars_numerator, card.ability.extra.mult, mult_denominator, card.ability.extra.dollars, dollars_denominator } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            local ret = {}
            if SMODS.pseudorandom_probability(card, 'vremade_lucky_mult', 1, card.ability.extra.mult_odds) then
                card.lucky_trigger = true
                ret.mult = card.ability.extra.mult
            end
            if SMODS.pseudorandom_probability(card, 'vremade_lucky_money', 1, card.ability.extra.dollars_odds) then
                card.lucky_trigger = true
                ret.dollars = card.ability.extra.dollars
            end
            -- 'lucky_trigger' is for Lucky Cat. Steamodded cleans this particular variable up for you, but in the general case you should do this:
            --[[
            G.E_MANAGER:add_event(Event {
               func = function()
                   card.lucky_trigger = nil
                   return true
               end
            )
            --]]
            return ret
        end
    end,
}
