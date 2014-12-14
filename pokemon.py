########################################################################################################################
#
# pokemon.py
#
# Purpose: Class to represent a Pokemon from Showdown
#
# Author: Braxton J. Schafer (bjschafer) [bjs]
#
# Creation date: 10/10/2014
#
# Copyright (c) 2014 Braxton J. Schafer
#
# Changelog:
#
########################################################################################################################

class pokemon():
    pretty_stats = {'spd': 'SpD', 'spa': 'SpA', 'atk': 'Atk', 'def': 'Def', 'spe': 'Spe', 'hp': 'HP'}

    def __init__(self, attrs):
        self.nickname = attrs['name']
        self.species = attrs['species']
        self.gender = attrs['gender'] if 'gender' in attrs else ''
        self.item = attrs['item']
        self.ability = attrs['ability']
        self.evs = attrs['evs']
        self.nature = attrs['nature']
        self.moves = attrs['moves']

    def __str__(self):
        return self.species

    def __repr__(self):
        return self.__str__()

    def _find_top_evs(self):
        top_evs = ''
        for stat, value in self.evs.items():
            if value and value > 0:
                top_evs += str(value) + ' ' + self.pretty_stats[stat] + ' / '

        return top_evs[:-2]

    def _pretty_moves(self):
        m = ''
        for move in self.moves:
            m += '- ' + move + '\n'
        return m

    def get_text(self):
        if self.nickname:
            repr = self.nickname + ' (' + self.species + ') '
        else:
            repr = self.species + ' '
        if self.gender:
            repr += '(' + self.gender + ') '
        repr += '@ ' + self.item + '\n'
        repr += 'Ability: ' + self.ability + '\n'
        repr += 'EVs: ' + self._find_top_evs() + '\n'
        repr += self.nature + " Nature" + '\n'
        repr += self._pretty_moves() + '\n'

        return repr
