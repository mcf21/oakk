
#include <eosiolib/eosio.hpp>
#include <eosiolib/print.hpp>

class tree_contract : public eosio::contract {
  public:
    tree_contract(account_name self)
      :eosio::contract(self),
      trees(_self, _self)
      {}

    // @abi action
    void plant(account_name planter, const std::string& trackerid, const uint32_t treetype) {
      require_auth( planter );
      
      trees.emplace(planter, [&](auto& new_tree) {
        new_tree.id = trees.available_primary_key();
        new_tree.trackerid  = trackerid;
        new_tree.planter = planter;
        new_tree.treetype = treetype;
        new_tree.created_at = now();
      });

      eosio::print("planted tree");
    }

    // @abi action
    void destroy(account_name planter, const uint32_t id) {
      auto tree_lookup = trees.get(id);
      eosio_assert(tree_lookup.planter == planter, "must be planter to destroy");
      trees.erase(tree_lookup);

      eosio::print("destroyed tree with id ", id);
    }


  private:
    // @abi table trees i64
    struct tree {
      uint64_t id;
      std::string trackerid;
      uint64_t treetype;
      account_name planter;
      time created_at;

      uint64_t primary_key() const { return id; }
      EOSLIB_SERIALIZE(tree, (id)(trackerid)(treetype)(planter)(created_at))
    };

    typedef eosio::multi_index<N(trees), tree> tree_table;
    tree_table trees;
};

EOSIO_ABI(tree_contract, (plant)(destroy))