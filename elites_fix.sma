#include <amxmodx>
#include <hamsandwich>
#include <fakemeta>

#define PLUGIN "Elite Recoil Fix"
#define VER    "1.0"
#define AUTHOR "7//ELiTEs.res"

// 0.5 = half recoil, 0.0 = no recoil, 1.0 = unchanged
#define RECOIL_MULT  0.5

const XO_WEAPON = 4
const m_pPlayer = 41

public plugin_init()
{
    register_plugin(PLUGIN, VER, AUTHOR);
    RegisterHam(Ham_Weapon_PrimaryAttack, "weapon_elite", "OnEliteAttack", true); // post
}

public OnEliteAttack(weapon)
{
    new id = get_pdata_cbase(weapon, m_pPlayer, XO_WEAPON);
    if (id < 1 || id > get_maxplayers()) return HAM_IGNORED;
    if (!is_user_alive(id))              return HAM_IGNORED;

    new Float:punch[3];
    pev(id, pev_punchangle, punch);

    punch[0] *= RECOIL_MULT;
    punch[1] *= RECOIL_MULT;
    punch[2] *= RECOIL_MULT;

    set_pev(id, pev_punchangle, punch);

    return HAM_IGNORED;
}